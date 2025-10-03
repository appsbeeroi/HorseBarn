import UIKit

struct Care: Identifiable {
    let id: UUID
    var type: CareType?
    var horse: Horse?
    var date: Date
    var note: String
    
    var isLock: Bool {
         type == nil || note == "" || horse == nil
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.date = Date()
        self.note = isMock ? "Mock note" : ""
    }
    
    init(from ud: CareUD, horse: Horse) {
        self.id = ud.id
        self.type = ud.type
        self.horse = horse
        self.date = ud.date
        self.note = ud.note
    }
}


