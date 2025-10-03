import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isNotificationSetup") var isNotificationSetup = false
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedSettingsType: SettingsType?
    
    @State private var isNotificationEnable = false
    @State private var isShowNotificationAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 16) {
                navigation
                cells
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if let selectedSettingsType,
               let url = URL(string: selectedSettingsType.urlString) {
                WebView(url: url) {
                    self.selectedSettingsType = nil
                    self.isShowTabBar = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .onChange(of: isNotificationEnable) { isEnable in
            if isEnable {
                Task {
                    switch await NotificationPermissionManager.shared.currentStatus {
                        case .allowed:
                            isNotificationSetup = isEnable
                        case .denied:
                            isShowNotificationAlert = true
                        case .undetermined:
                            await NotificationPermissionManager.shared.requestAuthorization()
                    }
                }
            } else {
                isNotificationSetup = false
            }
        }
        .alert("Notification permission wasn't allowed", isPresented: $isShowNotificationAlert) {
            Button("Yes") {
                openSettings()
            }
            
            Button("No") {
                isNotificationEnable = false
            }
        } message: {
            Text("Open app settings?")
        }
    }
    
    private var navigation: some View {
        Text("Settings")
            .padding(.top, 30)
            .padding(.horizontal, 35)
            .font(.ultra(with: 35))
            .foregroundStyle(.hbBrown)
            .multilineTextAlignment(.center)
    }
    
    private var cells: some View {
        VStack(spacing: 8) {
            ForEach(SettingsType.allCases) { type in
                OptionRowView(item: type, isNotificationEnable: $isNotificationEnable) {
                    guard type != .notification else { return }
                    isShowTabBar = false
                    selectedSettingsType = type
                }
            }
        }
        .padding(.top, 40)
        .padding(.horizontal, 35)
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}

