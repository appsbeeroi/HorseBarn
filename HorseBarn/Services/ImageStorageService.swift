import UIKit

final class ImageStorageService {
    
    // MARK: - Singleton

    static let shared = ImageStorageService()
    
    // MARK: - Private Properties

    private let folderName = "StoredImages"
    private let fileManager = FileManager.default
    private let storageURL: URL

    // MARK: - Initializer

    private init() {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        storageURL = documentsURL.appendingPathComponent(folderName, isDirectory: true)
        createFolderIfNeeded()
    }

    // MARK: - Private Helpers

    private func createFolderIfNeeded() {
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: storageURL.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            do {
                try fileManager.createDirectory(at: storageURL, withIntermediateDirectories: true)
            } catch {
                print("📁❌ Directory creation failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func imageURL(for id: UUID) -> URL {
        return storageURL.appendingPathComponent("\(id.uuidString).png")
    }

    private func imageURL(for fileName: String) -> URL {
        return storageURL.appendingPathComponent(fileName)
    }
}

// MARK: - Public Interface

extension ImageStorageService {
    
    @discardableResult
    func storeImage(_ image: UIImage, id: UUID) async -> String? {
        let url = imageURL(for: id)
        
        guard let imageData = image.pngData() else {
            print("📷❌ PNG encoding failed")
            return nil
        }
        
        do {
            try imageData.write(to: url, options: .atomic)
            return url.lastPathComponent
        } catch {
            print("💾❌ Image write failed: \(error.localizedDescription)")
            return nil
        }
    }

    func retrieveImage(named fileName: String) async -> UIImage? {
        let url = imageURL(for: fileName)
        return UIImage(contentsOfFile: url.path)
    }

    func removeImage(id: UUID) async {
        let url = imageURL(for: id)
        
        guard fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print("🗑️❌ Image deletion failed: \(error.localizedDescription)")
        }
    }
}
