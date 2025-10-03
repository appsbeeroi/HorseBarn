import SwiftUI

struct TrainingsCellView: View {
    
    let training: Training
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                if let image = training.type?.icon {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(20)
                }
                
                VStack {
                    HStack {
                        Image(.Icons.calendar)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(training.date.formatted(.dateTime.year().month(.twoDigits).day()))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.ultra(with: 11))
                            .foregroundStyle(.hbBrown)
                    }
                    
                    Text(training.type?.title ?? "N/A")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.ultra(with: 17))
                        .foregroundStyle(.hbBrown)
                    
                    if let horse = training.horse {
                        HStack {
                            if let horseImage = horse.image {
                                Image(uiImage: horseImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 22, height: 22)
                                    .clipped()
                                    .cornerRadius(24)
                            }
                            
                            Text(horse.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.ultra(with: 11))
                                .foregroundStyle(.hbBrown)
                        }
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 8)
            .background(.hbBeige)
            .cornerRadius(23)
        }
    }
}
