import SwiftUI

@main
struct HorseBarnApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        await NotificationPermissionManager.shared.requestAuthorization()
                    }
                }
        }
    }
}
