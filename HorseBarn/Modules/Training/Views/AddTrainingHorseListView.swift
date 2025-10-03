import SwiftUI

struct AddTrainingHorseListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    @State var training: Training
    
    let isNew: Bool
    
    @State private var isShowAddTrainingTypeView = false
    
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
        .navigationDestination(isPresented: $isShowAddTrainingTypeView) {
            AddTrainingTypeView(training: training, hasDateSelected: !isNew, isNew: isNew)
        }
    }
    
    private var navigation: some View {
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
            
            Text("Add training")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 30))
                .foregroundStyle(.hbBrown)
                .minimumScaleFactor(0.5)
        }
        .padding(.top, 30)
        .padding(.horizontal, 35)
    }
    
    private var horses: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(viewModel.horses) { horse in
                    CareHorseListCellView(
                        horse: horse,
                        horses: viewModel.horses,
                        selectedHorse: $training.horse
                    )
                }
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            isShowAddTrainingTypeView.toggle()
        } label: {
            Text("Save")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .background(training.horse == nil ? .gray.opacity(0.5) : .hbOrange)
                .cornerRadius(25)
                .foregroundStyle(.white)
        }
        .disabled(training.horse == nil)
    }
}

#Preview {
    AddTrainingHorseListView(training: Training(isMock: true), isNew: false)
        .environmentObject(TrainingViewModel())
}
