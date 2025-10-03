enum SettingsType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case about
    case privacy
    case notification
    
    var title: String {
        switch self {
            case .about:
                "About the developer"
            case .privacy:
                "Privacy Policy"
            case .notification:
                "Notification"
        }
    }
    #warning("ссылки")
    var urlString: String {
        switch self {
            case .about:
                "https://sites.google.com/view/horsebarn/home"
            case .privacy:
                "https://sites.google.com/view/horsebarn/privacy-policy"
            case .notification:
                ""
        }
    }
}
