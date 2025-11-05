enum SettingsType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case about
    case privacy
    case notification
    case callSupport
    
    var title: String {
        switch self {
            case .about:
                "About the developer"
            case .privacy:
                "Privacy Policy"
            case .notification:
                "Notification"
            case .callSupport:
                "Call support"
        }
    }
    
    var urlString: String {
        switch self {
            case .about:
                "https://sites.google.com/view/horsebarn/home"
            case .privacy:
                "https://sites.google.com/view/horsebarn/privacy-policy"
            case .callSupport:
                "https://sites.google.com/view/horsebarn/app-support"
            case .notification:
                ""
        }
    }
}
