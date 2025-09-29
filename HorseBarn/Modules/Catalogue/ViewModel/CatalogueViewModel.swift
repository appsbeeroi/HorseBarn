import UIKit

final class CatalogueViewModel: ObservableObject {
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var horses: [Horse] = []
    
    func loadHorses() {
        Task { [weak self] in
            guard let self else { return }
            
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
    
    func save(_ horse: Horse) {
        Task { [weak self] in
            guard let self else { return }
            
            var horsesUD = UserDefaultsManager.instance.load([HorseUD].self, key: .horse) ?? []
            
            guard let image = horse.image,
                  let imagePath = await ImageStorageService.shared.storeImage(image, id: horse.id) else { return }
            
            if let index = horsesUD.firstIndex(where: { $0.id == horse.id }) {
                horsesUD[index] = HorseUD(from: horse, and: imagePath)
            } else {
                horsesUD.append(HorseUD(from: horse, and: imagePath))
            }
            
            UserDefaultsManager.instance.save(horsesUD, key: .horse)
            
            await MainActor.run {
                self.isCloseNavigation = true
            }
        }
    }
    
    func save(_ horses: [Horse]) {
        Task { [weak self] in
            guard let self else { return }
            
            UserDefaultsManager.instance.deleteValue(for: .horse)
            
            let result = await withTaskGroup(of: HorseUD?.self) { group in
                for horse in horses {
                    group.addTask {
                        guard let image = horse.image,
                              let imagePath = await ImageStorageService.shared.storeImage(image, id: horse.id) else { return nil }
                        
                        let horseUD = HorseUD(from: horse, and: imagePath)
                        
                        return horseUD
                    }
                }
                
                var horsesUD: [HorseUD?] = []
                
                for await horseUD in group {
                    horsesUD.append(horseUD)
                }
                
                return horsesUD.compactMap { $0 }
            }
            
            UserDefaultsManager.instance.save(result, key: .horse)
            
            await MainActor.run {
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ horse: Horse) {
        Task { [weak self] in
            guard let self else { return }
            
            var horsesUD = UserDefaultsManager.instance.load([HorseUD].self, key: .horse) ?? []
            
            await ImageStorageService.shared.removeImage(id: horse.id)
            
            if let index = horsesUD.firstIndex(where: { $0.id == horse.id }) {
                horsesUD.remove(at: index)
            }
            
            UserDefaultsManager.instance.save(horsesUD, key: .horse)
            
            await MainActor.run {
                self.isCloseNavigation = true
            }
        }
    }
}
