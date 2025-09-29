import Foundation

struct HorseUD: Codable {
    var id: UUID
    var imagePath: String?
    var name: String
    var breed: String
    var age: String
    var isFavorite: Bool
    
    init(from model: Horse, and imagePath: String) {
        self.id = model.id
        self.imagePath = imagePath
        self.name = model.name
        self.breed = model.breed
        self.age = model.age
        self.isFavorite = model.isFavorite
    }
}
