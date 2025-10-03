import SwiftUI

struct TrainingView: View {
    
    @StateObject private var viewModel = TrainingViewModel()
    
    @Binding var isShowTabBar: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            ZStack {
                Image(.Images.bgClear)
                    .reorganize()
                
                VStack(spacing: UIScreen.isSE ? 10 : 28) {
                    navigation
                    
                    if viewModel.trainings.isEmpty {
                        stumb
                    } else {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 16) {
                                activities
                                trainings
                            }
                            .padding(.horizontal, 35)
                            
                            Color.clear
                                .frame(height: 80)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 30)
                .animation(.smooth, value: viewModel.horses)
            }
            .navigationDestination(for: TrainingScreen.self) { screen in
                switch screen {
                    case .detail:
                        TrainingDetailView(training: viewModel.selectedTraining ?? Training(isMock: false))
                    case .horseList:
                        AddTrainingHorseListView(
                            training: viewModel.selectedTraining ?? Training(isMock: false),
                            isNew: viewModel.selectedTraining == nil
                        )
                }
            }
            .onAppear {
                isShowTabBar = true
                viewModel.selectedTraining = nil
                viewModel.loadTrainings()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        Text("Training &\nwork")
            .font(.ultra(with: 35))
            .foregroundStyle(.hbBrown)
            .multilineTextAlignment(.center)
    }
    
    private var stumb: some View {
        VStack(spacing: UIScreen.isSE ? 10 : 24) {
            Image(.Images.Training.stumb)
                .resizable()
                .scaledToFit()
                .frame(width: 190, height: 230)
            
            VStack(spacing: 10) {
                Text("No training sessions\nrecorded")
                    .font(.ultra(with: 20))
                    .foregroundStyle(.hbBrown)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Start tracking your horse’s workouts to monitor progress and plan future sessions")
                    .font(.ultra(with: 14))
                    .foregroundStyle(.hbBrown.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if !viewModel.horses.isEmpty {
                addTraining
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var activities: some View {
        VStack(spacing: 16) {
            Text("Wealth of activities")
                .font(.ultra(with: 20))
                .foregroundStyle(.hbBrown)
            
            HStack(spacing: 25) {
                VStack {
                    Text("per month")
                        .font(.ultra(with: 11))
                        .foregroundStyle(.hbBrown.opacity(0.5))
                    
                    Text("\(viewModel.trainingsThisMonth)")
                        .font(.ultra(with: 35))
                        .foregroundStyle(.hbBrown)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                VStack {
                    Text("per week")
                        .font(.ultra(with: 11))
                        .foregroundStyle(.hbBrown.opacity(0.5))
                    
                    Text("\(viewModel.trainingsThisWeek)")
                        .font(.ultra(with: 35))
                        .foregroundStyle(.hbBrown)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(.hbBeige)
        .cornerRadius(20)
    }
    
    private var trainings: some View {
        LazyVStack(spacing: 8) {
            ForEach(viewModel.trainings) { training in
                TrainingsCellView(training: training) {
                    viewModel.selectedTraining = training
                    isShowTabBar = false
                    viewModel.path.append(.detail)
                }
            }
            
            addTraining
        }
    }
    
    private var addTraining: some View {
        Button {
            isShowTabBar = false
            viewModel.path.append(.horseList)
        } label: {
            Text("Add training")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .background(.hbOrange)
                .foregroundStyle(.white)
                .cornerRadius(25)
        }
    }
}

#Preview {
    TrainingView(isShowTabBar: .constant(false))
}



