import SwiftUI

struct CareDetailView: View {
    
    @EnvironmentObject var viewModel: CareViewModel
    
    @State var care: Care
    
    @State private var isShowEditView = false
    
    var body: some View {
        ZStack {
            Image(.Images.bgClear)
                .reorganize()
            
            VStack(spacing: 28) {
                navigation
                
                VStack(spacing: 24) {
                    title
                    info
                    horse
                }
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowEditView) {
            AddCareView(care: care, isNew: false)
        }
    }
    
    private var navigation: some View {
        HStack {
            Button {
                viewModel.save(care)
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
                    viewModel.remove(care)
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 30)
        .padding(.horizontal, 35)
    }
    
    private var title: some View {
        VStack(spacing: 16) {
            Text(care.type?.title ?? "N/A")
                .font(.ultra(with: 35))
                .foregroundStyle(.hbBrown)
            
            if let image = care.type?.icon {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
        }
    }
    
    private var info: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.ultra(with: 13))
                    .foregroundStyle(.hbBrown.opacity(0.5))
                
                Text(care.date.formatted(.dateTime.year().month(.twoDigits).day()))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.ultra(with: 19))
                    .foregroundStyle(.hbBrown)
            }
            
            VStack {
                Text("Note")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.ultra(with: 13))
                    .foregroundStyle(.hbBrown.opacity(0.5))
                
                Text(care.note)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.ultra(with: 19))
                    .foregroundStyle(.hbBrown)
            }
        }
    }
    
    private var horse: some View {
        VStack {
            Text("Horse")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 13))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            if let horse = care.horse {
                CatalogueHorseCellView(horse: horse) {}
                    .disabled(true)
            }
        }
    }
}

#Preview {
    CareDetailView(care: Care(isMock: true))
        .environmentObject(CareViewModel())
}
