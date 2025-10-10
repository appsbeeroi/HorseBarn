import SwiftUI

struct SplashScreen: View {
    
    @Binding var isLaunchMain: Bool
        
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack {
                Text("HorseBarn")
                    .font(.ultra(with: 48))
                    .foregroundStyle(.hbBrown)
                
                ProgressView()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 200)
        }
        .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
            withAnimation {
                isLaunchMain = true
            }
        }
    }
}

#Preview {
    SplashScreen(isLaunchMain: .constant(false))
}
