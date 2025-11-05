import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    
    let keyboard: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    init(
        text: Binding<String>,
        keyboard: UIKeyboardType = .default,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.keyboard = keyboard
        self._isFocused = isFocused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text("Write here...")
                .foregroundColor(.hbBrown.opacity(0.5)))
            .font(.ultra(with: 19))
            .foregroundStyle(.hbBrown)
            .keyboardType(keyboard)
            .focused($isFocused)
            
            if text != "" {
                Button {
                    text = ""
                    isFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 19, weight: .medium))
                        .foregroundStyle(.gray.opacity(0.3))
                }
            }
        }
        .frame(height: 65)
        .padding(.horizontal, 20)
        .background(.hbBeige)
        .cornerRadius(25)
    }
}
