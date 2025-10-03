import SwiftUI

enum TrainingScreen: Hashable {
    case horseList
    case detail
}

final class TrainingViewModel: ObservableObject {
    
    @Published var path: [TrainingScreen] = []
    @Published var selectedTraining: Training?
    
    @Published private(set) var trainings: [Training] = []
    
    var trainingsThisWeek: Int {
           let calendar = Calendar.current
           let now = Date()
           guard let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) else { return 0 }
           return trainings.filter { $0.date >= weekAgo }.count
       }
       
       var trainingsThisMonth: Int {
           let calendar = Calendar.current
           let now = Date()
           guard let monthAgo = calendar.date(byAdding: .month, value: -1, to: now) else { return 0 }
           return trainings.filter { $0.date >= monthAgo }.count
       }
    
    private(set) var horses: [Horse] = [Horse(isMock: true)]
    
    func loadTrainings() {
        Task { [weak self] in
            guard let self else { return }
            
            await self.loadHorses()
            
            let trainingsUD = UserDefaultsManager.instance.load([TrainingUD].self, key: .training) ?? []
            
            let result = await withTaskGroup(of: Training?.self) { group in
                for trainingUD in trainingsUD {
                    group.addTask {
                        guard let horse = self.horses.first(where: { $0.id == trainingUD.horseID }) else { return nil }
                        
                        let training = Training(from: trainingUD, horse: horse)
                        
                        return training
                    }
                }
                
                var trainings: [Training?] = []
                
                for await training in group {
                    trainings.append(training)
                }
                
                return trainings.compactMap { $0 }
            }
            
            await MainActor.run {
                self.trainings = result.sorted(by: { $0.date < $1.date })
            }
        }
    }
    
    func save(_ training: Training) {
        Task { [weak self] in
            guard let self else { return }
            
            var trainingsUD = UserDefaultsManager.instance.load([TrainingUD].self, key: .training) ?? []
            
            if let index = trainingsUD.firstIndex(where: { $0.id == training.id }) {
                trainingsUD[index] = TrainingUD(from: training)
            } else {
                trainingsUD.append(TrainingUD(from: training))
            }
            
            UserDefaultsManager.instance.save(trainingsUD, key: .training)
            
            await MainActor.run {
                self.path.removeAll()
            }
        }
    }
    
    func remove(_ training: Training) {
        Task { [weak self] in
            guard let self else { return }
            
            var trainingsUD = UserDefaultsManager.instance.load([TrainingUD].self, key: .training) ?? []
            
            if let index = trainingsUD.firstIndex(where: { $0.id == training.id }) {
                trainingsUD.remove(at: index)
            }
            
            UserDefaultsManager.instance.save(trainingsUD, key: .training)
            
            await MainActor.run {
                self.path.removeAll()
            }
        }
    }
    
    private func loadHorses() async {
        let horsesUD = UserDefaultsManager.instance.load([HorseUD].self, key: .horse) ?? []
        
        let result = await withTaskGroup(of: Horse?.self) { group in
            for horseUD in horsesUD {
                group.addTask {
                    guard let image = await ImageStorageService.shared.retrieveImage(named: horseUD.id.uuidString) else { return nil }
                    let horse = Horse(from: horseUD, and: image)
                    
                    return horse
                }
            }
            
            var horses: [Horse?] = []
            
            for await horse in group {
                horses.append(horse)
            }
            
            return horses.compactMap { $0 }
        }
        
        await MainActor.run {
            self.horses = result.sorted(by: { $0.name < $1.name })
        }
    }
}
