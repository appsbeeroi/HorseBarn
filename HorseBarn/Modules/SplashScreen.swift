import SwiftUI

struct SplashScreen: View {
    
    @Binding var isLaunchMain: Bool
    
    @State private var isAnimating = false
    
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isLaunchMain = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isLaunchMain: .constant(false))
}
