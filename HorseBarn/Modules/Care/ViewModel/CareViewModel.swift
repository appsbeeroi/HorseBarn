import UIKit

final class CareViewModel: ObservableObject {
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var cares: [Care] = []
    
    private(set) var horses: [Horse] = []
    
    func loadCares() {
        Task { [weak self] in
            guard let self else { return }
            
            await self.loadHorses()
            
            let caresUD = UserDefaultsManager.instance.load([CareUD].self, key: .care) ?? []
            
            let result = await withTaskGroup(of: Care?.self) { group in
                for careUD in caresUD {
                    group.addTask {
                        guard let horse = self.horses.first(where: { $0.id == careUD.horseID }) else { return nil }
                        
                        let care = Care(from: careUD, horse: horse)
                        
                        return care
                    }
                }
                
                var cares: [Care?] = []
                
                for await care in group {
                    cares.append(care)
                }
                
                return cares.compactMap { $0 }
            }
            
            await MainActor.run {
                self.cares = result.sorted(by: { $0.date < $1.date })
            }
        }
    }
    
    private func loadHorses() async {
        let horsesUD = UserDefaultsManager.instance.load([HorseUD].self, key: .horse) ?? []
        
        let result = await withTaskGroup(of: Horse?.self) { group in
            for horseUD in horsesUD {
                group.addTask {
                    guard let image = await ImageStorageService.shared.retrieveImage(named: horseUD.id.uuidString) else { return nil }
                    let horse = Horse(from: horseUD, and: image)
                    
                    return horse
                }
            }
            
            var horses: [Horse?] = []
            
            for await horse in group {
                horses.append(horse)
            }
            
            return horses.compactMap { $0 }
        }
        
        await MainActor.run {
            self.horses = result.sorted(by: { $0.name < $1.name })
        }
    }
    
    func save(_ care: Care) {
        Task { [weak self] in
            guard let self else { return }
            
            var caresUD = UserDefaultsManager.instance.load([CareUD].self, key: .care) ?? []
            
            if let index = caresUD.firstIndex(where: { $0.id == care.id }) {
                caresUD[index] = CareUD(from: care)
            } else {
                caresUD.append(CareUD(from: care))
            }
            
            UserDefaultsManager.instance.save(caresUD, key: .care)
            
            await MainActor.run {
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ care: Care) {
        Task { [weak self] in
            guard let self else { return }
            
            var caresUD = UserDefaultsManager.instance.load([CareUD].self, key: .care) ?? []
            
            if let index = caresUD.firstIndex(where: { $0.id == care.id }) {
                caresUD.remove(at: index)
            }
            
            UserDefaultsManager.instance.save(caresUD, key: .care)
            
            await MainActor.run {
                self.isCloseNavigation = true
            }
        }
    }
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

// MARK: - Utilities
enum CryptoUtils {
    static func md5Hex(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
