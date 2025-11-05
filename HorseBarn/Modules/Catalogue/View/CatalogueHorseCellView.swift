import SwiftUI

struct CatalogueHorseCellView: View {
    
    let horse: Horse
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                if let image = horse.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 104, height: 104)
                        .clipped()
                        .cornerRadius(24)
                }
                
                VStack(spacing: 6) {
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
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.hbBeige)
                    .overlay {
                        Image(systemName: horse.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.hbOrange)
                    }
                    .frame(maxHeight: .infinity, alignment: .topTrailing)
            }
            .padding(8)
            .background(.hbBeige)
            .cornerRadius(23)
        }
    }
}
