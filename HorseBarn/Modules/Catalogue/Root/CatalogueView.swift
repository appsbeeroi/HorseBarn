import SwiftUI

struct CatalogueView: View {
    
    @StateObject private var viewModel = CatalogueViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedHorse: Horse?
    @State private var isShowAddHorseView = false
    @State private var isShowFavorites = false
    @State private var isShowHorseDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.bgClear)
                    .reorganize()
                
                VStack(spacing: 28) {
                    navigation
                    
                    if viewModel.horses.isEmpty {
                        stumb
                    } else {
                        horses
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
                .animation(.smooth, value: viewModel.horses)
            }
            .navigationDestination(isPresented: $isShowAddHorseView) {
                AddHorseView(horse: selectedHorse ?? Horse(isMock: false)) { horse in
                    viewModel.save(horse)
                }
            }
            .navigationDestination(isPresented: $isShowHorseDetailView) {
                CatalogueHorseDetailView(horse: selectedHorse ?? Horse(isMock: false)) { newHorse in
                    viewModel.save(newHorse)
                } removeAction: { removedHorse in
                    viewModel.remove(removedHorse)
                }
            }
            .navigationDestination(isPresented: $isShowFavorites) {
                CatalogueFavoritesView(horses: viewModel.horses) { newHorses in
                    viewModel.save(newHorses)
                }
            }
            .onAppear {
                isShowTabBar = true
                selectedHorse = nil
                viewModel.loadHorses()
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    viewModel.isCloseNavigation = false
                    isShowFavorites = false
                    isShowAddHorseView = false
                    isShowHorseDetailView = false
                }
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            Text("Horse\ncatalogue")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 35))
                .foregroundStyle(.hbBrown)
                .multilineTextAlignment(.leading)
            
            Button {
                isShowTabBar = false
                isShowFavorites.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 13)
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.hbOrange)
                    .overlay {
                        Image(systemName: "heart")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Image(.Images.Catalogue.horseStumb)
                .resizable()
                .scaledToFit()
                .frame(width: 190, height: 230)
            
            VStack(spacing: 10) {
                Text("No horses added yet")
                    .font(.ultra(with: 20))
                    .foregroundStyle(.hbBrown)
                
                Text("Add your first horse to start tracking its care, training, and notes")
                    .font(.ultra(with: 14))
                    .foregroundStyle(.hbBrown.opacity(0.75))
                    .multilineTextAlignment(.center)
            }
            
            addHorse
        }
        .padding(.horizontal, 35)
    }
    
    private var addHorse: some View {
        Button {
            isShowTabBar = false
            isShowAddHorseView.toggle()
        } label: {
            Text("Add horse")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .foregroundStyle(.white)
                .background(.hbOrange)
                .cornerRadius(25)
        }
    }
    
    private var horses: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.horses) { horse in
                    CatalogueHorseCellView(horse: horse) {
                        selectedHorse = horse
                        isShowTabBar = false
                        isShowHorseDetailView.toggle()
                    }
                }
                
                addHorse
            }
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    CatalogueView(isShowTabBar: .constant(false))
}


