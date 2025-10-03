import Foundation

struct Training: Identifiable, Equatable {
    let id: UUID
    var type: TrainingType?
    var date: Date
    var horse: Horse?
    
    init(isMock: Bool) {
        self.id = UUID()
        self.type = isMock ? .fieldWork : nil
        self.date = Date()
        self.horse = isMock ? Horse(isMock: true) : nil
    }
    
    init(from ud: TrainingUD, horse: Horse) {
        self.id = ud.id
        self.type = ud.type
        self.date = ud.date
        self.horse = horse
    }
}
