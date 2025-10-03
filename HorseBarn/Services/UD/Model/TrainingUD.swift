import Foundation

struct TrainingUD: Codable {
    let id: UUID
    let type: TrainingType?
    let date: Date
    let horseID: UUID
    
    init(from model: Training) {
        self.id = model.id
        self.type = model.type
        self.date = model.date
        self.horseID = model.horse?.id ?? UUID()
    }
}
