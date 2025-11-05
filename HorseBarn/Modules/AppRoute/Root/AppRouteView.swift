import SwiftUI

struct AppRouteView: View {
    
    @State private var selection: AppRouteState = .catalogue
    
    @State private var isShowTabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                CatalogueView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.catalogue)
                
                CareView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.care)
                
                TrainingView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.training)
                
                SettingsView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.settings)
            }
            
            VStack {
                HStack {
                    ForEach(AppRouteState.allCases) { state in
                        Button {
                            selection = state
                        } label: {
                            Image(state.icon)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 37, height: 37)
                                .foregroundColor(.hbOrange.opacity(state == selection ? 1 : 0.5))
                        }
                        
                        if state != .settings {
                            Spacer()
                        }
                    }
                }
                .padding(.top, 13)
                .padding(.horizontal, 35)
                .padding(.bottom, UIScreen.isSE ? 10 : 44)
                .background(
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, topTrailing: 20))
                        .fill(.white)
                )
                .opacity(isShowTabBar ? 1 : 0)
                .animation(.easeInOut, value: isShowTabBar)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    AppRouteView()
}
