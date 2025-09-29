import SwiftUI

struct ContentView: View {
    
    @State private var isLaunchMain = false
    
    var body: some View {
        if isLaunchMain {
            AppRouteView()
        } else {
            SplashScreen(isLaunchMain: $isLaunchMain)
        }
    }
}

#Preview {
    ContentView()
}
