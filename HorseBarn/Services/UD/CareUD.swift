import Foundation

struct CareUD: Codable {
    let id: UUID
    let type: CareType
    let horseID: UUID
    let date: Date
    let note: String
    
    init(from model: Care) {
        self.id = model.id
        self.type = model.type ?? .cleaning
        self.horseID = model.horse?.id ?? UUID()
        self.date = model.date
        self.note = model.note
    }
}
