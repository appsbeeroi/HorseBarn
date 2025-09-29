import SwiftUI

struct CatalogueFavoritesView: View {
    
    @State var horses: [Horse]
    
    let saveAction: ([Horse]) -> Void
    
    var favorites: [Horse] {
        horses.filter { $0.isFavorite}
    }
    
    @State private var selectedHorse: Horse?
    @State private var isShowDetailView = false
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 16) {
                navigation
                
                if favorites.isEmpty {
                    stumb
                } else {
                    horsesList
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if isLoading {
               LoadingView()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowDetailView) {
            CatalogueHorseDetailView(horse: selectedHorse ?? Horse(isMock: false)) { newHorse in
                guard let index = horses.firstIndex(where: { $0.id == newHorse.id }) else { return }
                horses[index] = newHorse
                isShowDetailView = false
            } removeAction: { removedHorse in
                guard let index = horses.firstIndex(where: { $0.id == removedHorse.id }) else { return }
                horses.remove(at: index)
                isShowDetailView = false
            }
        }
    }
    
    private var navigation: some View {
        ZStack {
            HStack {
                Button {
                    withAnimation {
                        isLoading = true
                    }
                    
                    saveAction(horses)
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
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Image(.Images.Catalogue.horseStumb)
                .resizable()
                .scaledToFit()
                .frame(width: 190, height: 230)
            
            VStack(spacing: 10) {
                Text("No favorites yet")
                    .font(.ultra(with: 20))
                    .foregroundStyle(.hbBrown)
                
                Text("Mark your favorite horses here to access them quickly and easily")
                    .font(.ultra(with: 14))
                    .foregroundStyle(.hbBrown.opacity(0.75))
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var horsesList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(favorites) { horse in
                    CatalogueHorseCellView(horse: horse) {
                        selectedHorse = horse
                        isShowDetailView.toggle()
                    }
                }
            }
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    CatalogueFavoritesView(horses: []) { _ in }
}
