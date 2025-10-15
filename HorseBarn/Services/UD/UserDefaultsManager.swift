import Foundation

final class UserDefaultsManager {

    // MARK: - Singleton

    static let instance = UserDefaultsManager()

    // MARK: - Private Properties

    private let userDefaults = UserDefaults.standard
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    // MARK: - Public Method:

    func load<T: Codable>(_ type: T.Type, key: UDKeys) -> T? {
        guard let storedData = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }

        do {
            let decodedObject = try jsonDecoder.decode(T.self, from: storedData)
            return decodedObject
        } catch {
            debugPrint("⚠️ Decoding failed for \(T.self): \(error.localizedDescription)")
            return nil
        }
    }
    
    func save<T: Codable>(_ object: T, key: UDKeys) {
        do {
            let encoded = try jsonEncoder.encode(object)
            userDefaults.set(encoded, forKey: key.rawValue)
        } catch {
            debugPrint("⚠️ Encoding failed for \(T.self): \(error.localizedDescription)")
        }
    }

    func deleteValue(for key: UDKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
