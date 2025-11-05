enum CareType: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case feeding
    case cleaning
    case vaccination
    
    var title: String {
        switch self {
            case .feeding:
                "Feeding"
            case .cleaning:
                "Cleaning"
            case .vaccination:
                "Vaccination"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .feeding:
                    .Images.Care.feeding
            case .cleaning:
                    .Images.Care.cleaning
            case .vaccination:
                    .Images.Care.vaccination
        }
    }
}
