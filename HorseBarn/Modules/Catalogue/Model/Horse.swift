import UIKit

struct Horse: Identifiable, Equatable {
    var id: UUID
    var image: UIImage?
    var name: String
    var breed: String
    var age: String
    var isFavorite: Bool = false 
    
    var isReadyToSave: Bool {
        image != nil && name != "" && breed != "" && age != ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.image = isMock ? UIImage(resource: .Images.Catalogue.horseStumb) : nil 
        self.name = isMock ? "Horse" : ""
        self.breed = isMock ? "Breed" : ""
        self.age = isMock ? "Age" : ""
    }
    
    init(from ud: HorseUD, and image: UIImage) {
        self.id = ud.id
        self.image = image
        self.name = ud.name
        self.breed = ud.name
        self.age = ud.age
        self.isFavorite = ud.isFavorite
    }
}
