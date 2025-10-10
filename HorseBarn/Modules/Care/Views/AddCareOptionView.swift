import SwiftUI

struct AddCareOptionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: CareViewModel
    
    @State var care: Care
    
    @State var hasDateSelected: Bool
    
    @State private var isShowDatePicker = false
    @State private var isLoading = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.bgHorse)
                .reorganize()
            
            VStack(spacing: 16) {
                navigation
                
                VStack(spacing: 8) {
                    date
                    note
                    
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
            
            if isLoading {
                LoadingView()
            }
        }
        .navigationBarBackButtonHidden()
        .onChange(of: care.date) { _ in 
            hasDateSelected = true
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
    
    private var date: some View {
        HStack {
            Button {
                withAnimation {
                    isShowDatePicker.toggle()
                }
            } label: {
                Text(hasDateSelected ? care.date.formatted(.dateTime.year().month(.twoDigits).day()) : "Date")
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
                
                DatePicker("", selection: $care.date, displayedComponents: [.date])
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
    
    private var note: some View {
        VStack(spacing: 2) {
            Text("Note")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.ultra(with: 14))
                .foregroundStyle(.hbBrown.opacity(0.5))
            
            CustomTextField(text: $care.note, isFocused: $isFocused)
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.save(care)
        } label: {
            Text("Save")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.ultra(with: 20))
                .background(hasDateSelected && care.note != "" ? .hbOrange : .gray.opacity(0.5))
                .foregroundStyle(.white)
                .cornerRadius(20)
        }
        .disabled(!hasDateSelected || care.note == "")
    }
}

#Preview {
    AddCareOptionView(care: Care(isMock: true), hasDateSelected: true)
        .environmentObject(CareViewModel())
}

#Preview {
    AddCareOptionView(care: Care(isMock: true), hasDateSelected: false)
        .environmentObject(CareViewModel())
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

extension Notification.Name {
    static let didFetchTrackingURL = Notification.Name("didFetchTrackingURL")
    static let checkTrackingPermission = Notification.Name("checkTrackingPermission")
    static let notificationPermissionResolved = Notification.Name("notificationPermissionResolved")
    static let splashTransition = Notification.Name("splashTransition")
}
