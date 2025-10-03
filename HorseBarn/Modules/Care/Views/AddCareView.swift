import SwiftUI

struct AddCareView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var care: Care
    
    let isNew: Bool
    @State private var isShowHorseListView = false
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 16) {
                navigation
                
                VStack(spacing: 8) {
                    title
                    careTypes
                    
                    Spacer()
                    
                    saveButton
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 35)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowHorseListView) {
            AddCareHorseListView(care: care, isNew: isNew)
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
    
    private var title: some View {
        Text("Type of care")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.ultra(with: 14))
            .foregroundStyle(.hbBrown.opacity(0.75))
    }
    
    private var careTypes: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                getTypeCareButton(for: .cleaning)
                getTypeCareButton(for: .feeding)
            }
            
            HStack(spacing: 10) {
                getTypeCareButton(for: .vaccination)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func getTypeCareButton(for type: CareType) -> some View {
        Button {
            care.type = type
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
                .background(care.type == type ? .hbOrange : .clear)
                .cornerRadius(32)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            isShowHorseListView.toggle()
        } label: {
            Text("Save")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .background(care.type == nil ? .gray.opacity(0.5) : .hbOrange)
                .cornerRadius(25)
                .foregroundStyle(.white)
        }
        .disabled(care.type == nil )
    }
}

#Preview {
    AddCareView(care: Care(isMock: true), isNew: false)
}

