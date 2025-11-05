import UIKit

enum AppRouteState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case catalogue
    case care
    case training
    case settings
    
    var icon: ImageResource {
        switch self {
            case .catalogue:
                    .Images.TabBar.catalogue
            case .care:
                    .Images.TabBar.care
            case .training:
                    .Images.TabBar.training
            case .settings:
                    .Images.TabBar.settings
        }
    }
}
