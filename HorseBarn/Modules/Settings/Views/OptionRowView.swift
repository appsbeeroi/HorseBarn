import SwiftUI

struct OptionRowView: View {
    
    let item: SettingsType
    
    @Binding var isNotificationEnable: Bool
    
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(item.title)
                    .font(.ultra(with: 17))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if item != .notification {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.hbBrown)
                }
                
                if item == .notification {
                    Toggle(isOn: $isNotificationEnable) {}
                        .labelsHidden()
                        .tint(.hbOrange)
                }
            }
            .padding(.horizontal, 14)
            .frame(height: 65)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
    }
}
