import SwiftUI

struct AddHorseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var horse: Horse
    
    let saveAction: (Horse) -> Void
    
    @State private var isShowImagePicker = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 0) {
                navigation
                
                VStack(spacing: 16) {
                    image
                    name
                    breed
                    age
                    
                    Spacer()
                    
                    saveButton
                }
                .padding(.top, 30)
                .padding(.horizontal, 35)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Button("Done") {
                                isFocused = false
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $horse.image)
        }
    }
    
    private var navigation: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: 42, height: 42)
                        .foregroundStyle(.hbOrange)
                        .overlay {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Add horse")
                .font(.ultra(with: 35))
                .foregroundStyle(.hbBrown)
        }
        .padding(.top, 30)
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Button {
            isShowImagePicker.toggle()
        } label: {
            ZStack {
                if let image = horse.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 108, height: 108)
                        .clipped()
                        .cornerRadius(20)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 108, height: 108)
                        .foregroundStyle(.hbBeige)
                }
                
                Image(systemName: "photo")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.gray.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var name: some View {
        VStack(spacing: 2) {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 14))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            CustomTextField(text: $horse.name, isFocused: $isFocused)
        }
    }
    
    private var breed: some View {
        VStack(spacing: 2) {
            Text("Breed")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 14))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            CustomTextField(text: $horse.breed, isFocused: $isFocused)
        }
    }
    
    private var age: some View {
        VStack(spacing: 2) {
            Text("Age")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 14))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            CustomTextField(text: $horse.age, keyboard: .numberPad, isFocused: $isFocused)
        }
    }
    
    private var saveButton: some View {
        Button {
            saveAction(horse)
        } label: {
            Text("Save")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .foregroundStyle(.white)
                .background(horse.isReadyToSave ? .hbOrange : .gray)
                .cornerRadius(25)
        }
        .disabled(!horse.isReadyToSave)
    }
}

#Preview {
    AddHorseView(horse: Horse(isMock: true)) { _ in }
}



