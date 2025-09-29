import SwiftUI

struct CatalogueHorseDetailView: View {
    
    @State var horse: Horse
    
    let saveAction: (Horse) -> Void
    let removeAction: (Horse) -> Void
    
    @State private var isShowEditView = false
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 10) {
                image
                
                VStack(spacing: 14) {
                    name
                    breed
                    age
                    
                    Spacer()
                    
                    actionButtons
                }
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            
            if isLoading {
               LoadingView()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowEditView) {
            AddHorseView(horse: horse) { newHorse in
                self.horse = newHorse
                isShowEditView = false
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            Button {
                withAnimation {
                    isLoading = true
                }
                
                saveAction(horse)
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
            
            Spacer()
            
            Button {
                horse.isFavorite.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 13)
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.hbOrange)
                    .overlay {
                        Image(systemName: horse.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
        }
        .padding(.top, 54)
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Image(uiImage: horse.image ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(height: 400)
            .frame(maxWidth: UIScreen.main.bounds.width)
            .clipped()
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            .overlay(alignment: .top) {
                navigation
            }
    }
    
    private var name: some View {
        Text(horse.name)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.ultra(with: 35))
            .foregroundStyle(.hbBrown)
    }
    
    private var breed: some View {
        VStack(spacing: 0) {
            Text("Breed")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 13))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            Text(horse.breed)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 19))
                .foregroundStyle(.hbBrown)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var age: some View {
        VStack(spacing: 0) {
            Text("Age")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 13))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            Text(horse.age)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 19))
                .foregroundStyle(.hbBrown)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var actionButtons: some View {
        HStack {
            Button {
                isShowEditView.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(.Icons.edit)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
            }
            
            Button {
                removeAction(horse)
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.white)
                    .overlay {
                        Image(.Icons.remove)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 45)
    }
}

#Preview {
    CatalogueHorseDetailView(horse: Horse(isMock: true)) { _ in } removeAction: { _ in }
}
