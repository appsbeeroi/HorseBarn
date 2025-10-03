import UIKit

enum TrainingType: Codable {
    case riding
    case running
    case fieldWork
    
    var title: String {
        switch self {
            case .riding:
                "Riding"
            case .running:
                "Running"
            case .fieldWork:
                "Field work"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .riding:
                    .Images.Training.riding
            case .running:
                    .Images.Training.running
            case .fieldWork:
                    .Images.Training.field
        }
    }
}
