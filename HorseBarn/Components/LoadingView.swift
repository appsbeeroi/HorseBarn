import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 60, height: 60)
            .foregroundStyle(.hbBeige)
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.hbOrange, lineWidth: 1)
                        .frame(width: 60, height: 60)
                    
                    ProgressView()
                }
            }
    }
}

#Preview {
    LoadingView()
}
