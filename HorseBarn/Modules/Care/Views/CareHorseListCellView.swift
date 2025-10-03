import SwiftUI

struct CareHorseListCellView: View {
    
    let horse: Horse
    let horses: [Horse]
    
    @Binding var selectedHorse: Horse?
    
    var body: some View {
        Button {
            selectedHorse = horse
        } label: {
            HStack {
                if let image = horse.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 104, height: 104)
                        .clipped()
                        .cornerRadius(24)
                }
                
                VStack(spacing: 12) {
                    Text(horse.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.ultra(with: 20))
                        .foregroundStyle(.hbBrown)
                    
                    VStack(spacing: 0) {
                        Text("Breed")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.ultra(with: 11))
                            .foregroundStyle(.hbBrown.opacity(0.5))
                        
                        Text(horse.breed)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.ultra(with: 11))
                            .foregroundStyle(.hbBrown)
                    }
                }
                
                Circle()
                    .stroke(.hbOrange, lineWidth: 3)
                    .frame(width: 30, height: 30)
                    .overlay {
                        if horse.id == selectedHorse?.id ?? UUID() {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.orange)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .topTrailing)
                    .padding(10)
            }
            .padding(8)
            .background(.hbBeige)
            .cornerRadius(23)
            .frame(height: 120)
        }
    }
}
