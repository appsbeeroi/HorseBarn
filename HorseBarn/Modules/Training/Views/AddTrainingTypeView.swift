import SwiftUI

struct AddTrainingTypeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    @State var training: Training
    @State var hasDateSelected: Bool
    
    let isNew: Bool
    
    @State private var isShowDatePicker = false
        
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 16) {
                navigation
                
                VStack(spacing: 8) {
                    title
                    careTypes
                    date
                    
                    Spacer()
                    
                    saveButton
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if isShowDatePicker {
                datePicker
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            hasDateSelected = !isNew
        }
        .onChange(of: training.date) { _ in
            hasDateSelected = true
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
        }
        .padding(.top, 30)
        .padding(.horizontal, 35)
    }
    private var title: some View {
        Text("Type of training")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.ultra(with: 14))
            .foregroundStyle(.hbBrown.opacity(0.75))
    }
    
    private var careTypes: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                getTypeCareButton(for: .riding)
                getTypeCareButton(for: .running)
            }
            
            HStack(spacing: 10) {
                getTypeCareButton(for: .fieldWork)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func getTypeCareButton(for type: TrainingType) -> some View {
        Button {
            training.type = type
        } label: {
            ZStack {
                VStack {
                    Image(type.icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 125, height: 125)
                        .cornerRadius(20)
                    
                    Text(type.title)
                        .font(.ultra(with: 17))
                        .foregroundStyle(.hbBrown)
                }
                .padding(12)
                .background(training.type == type ? .hbOrange : .clear)
                .cornerRadius(32)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var date: some View {
        HStack {
            Button {
                withAnimation {
                    isShowDatePicker.toggle()
                }
            } label: {
                Text(hasDateSelected ? training.date.formatted(.dateTime.year().month(.twoDigits).day()) : "Date")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.ultra(with: 19))
                    .foregroundStyle(.hbBrown)
            }
            
            Image(.Icons.calendar)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .frame(height: 65)
        .padding(.horizontal, 20)
        .background(.hbBeige)
        .cornerRadius(25)
    }
    
    private var datePicker: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isShowDatePicker.toggle()
                    }
                }
            
            VStack {
                HStack {
                    Button("Close") {
                        isShowDatePicker.toggle()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                DatePicker("", selection: $training.date, displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .tint(.hbOrange)
                    .padding()
                    .background(.white)
                    .cornerRadius(28)
            }
            .padding()
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.save(training)
        } label: {
            Text("Save")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .background(training.type == nil ? .gray.opacity(0.5) : .hbOrange)
                .cornerRadius(25)
                .foregroundStyle(.white)
        }
        .disabled(training.type == nil )
    }
}

#Preview {
    AddTrainingTypeView(training: Training(isMock: true), hasDateSelected: false, isNew: false)
}

