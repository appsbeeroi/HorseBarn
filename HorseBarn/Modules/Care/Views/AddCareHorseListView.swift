import SwiftUI

struct AddCareHorseListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: CareViewModel
    
    @State var care: Care
    
    let isNew: Bool
    
    @State private var isShowAddCareOptionView = false
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 16) {
                navigation
                
                VStack(spacing: 8) {
                    horses
                    saveButton
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowAddCareOptionView) {
            AddCareOptionView(care: care, hasDateSelected: !isNew)
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
            
            Text("Add care")
                .font(.ultra(with: 35))
                .foregroundStyle(.hbBrown)
        }
        .padding(.top, 30)
        .padding(.horizontal, 35)
    }
    
    private var horses: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(viewModel.horses) { horse in
                    CareHorseListCellView(horse: horse, horses: viewModel.horses, selectedHorse: $care.horse)
                }
            }
        }
    }
    private var saveButton: some View {
        Button {
            isShowAddCareOptionView.toggle()
        } label: {
            Text("Save")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .background(care.horse == nil ? .gray.opacity(0.5) : .hbOrange)
                .cornerRadius(25)
                .foregroundStyle(.white)
        }
        .disabled(care.horse == nil)
    }
}

#Preview {
    AddCareHorseListView(care: Care(isMock: true), isNew: true)
        .environmentObject(CareViewModel())
}
