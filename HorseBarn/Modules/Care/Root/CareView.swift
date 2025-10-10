import SwiftUI

struct CareView: View {
    
    @StateObject private var viewModel = CareViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedCare: Care?
    @State private var isShowAddView = false
    @State private var isShowDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.bgHorse)
                    .reorganize()
                
                VStack(spacing: 16) {
                    navigation
                    
                    if viewModel.cares.isEmpty {
                        stumb
                    } else {
                        cares
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationDestination(isPresented: $isShowAddView) {
                AddCareView(care: selectedCare ?? Care(isMock: false), isNew: selectedCare == nil)
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                CareDetailView(care: selectedCare ?? Care(isMock: false))
            }
            .onAppear {
                selectedCare = nil
                isShowTabBar = true
                viewModel.loadCares()
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    viewModel.isCloseNavigation = false
                    isShowAddView = false
                    isShowDetailView = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        Text("Care\nAccounting")
            .padding(.top, 30)
            .padding(.horizontal, 35)
            .font(.ultra(with: 35))
            .foregroundStyle(.hbBrown)
            .multilineTextAlignment(.center)
    }
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Image(.Images.Care.brush)
                .resizable()
                .scaledToFit()
                .frame(width: 190, height: 230)
            
            VStack(spacing: 10) {
                Text("No care records yet")
                    .font(.ultra(with: 20))
                    .foregroundStyle(.hbBrown)
                
                Text("Log feeding, grooming, and veterinary visits to keep your horse healthy and happy")
                    .font(.ultra(with: 14))
                    .foregroundStyle(.hbBrown.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if !viewModel.horses.isEmpty {
                addButton
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var cares: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.cares) { care in
                    CaresCellView(care: care) {
                        selectedCare = care
                        isShowTabBar = false
                        isShowDetailView.toggle()
                    }
                }
                
                addButton
            }
            .padding(.horizontal, 35)
            
            Color.clear
                .frame(height: 80)
        }
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            isShowAddView.toggle()
        } label: {
            Text("Add care")
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
    CareView(isShowTabBar: .constant(false))
}


import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport

class OverlayPrivacyWindowController: UIViewController {
    var overlayView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
