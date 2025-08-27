
import Foundation

final class KeyStorage {
    static let shared = KeyStorage()

    private init() {}

    func getKey() -> String {
        let obfuscatedKey: [UInt8] = [20, 2, 18, 1, 29, 83, 16, 25, 1, 26, 20, 8, 83, 20, 1, 2, 21, 83]
        let xorValue: [UInt8] = [88, 89, 90, 89, 88, 90, 88, 89, 90, 89, 88, 90, 88, 89, 90, 89, 88, 90]

        var deobfuscatedKeyBytes = [UInt8]()
        for i in 0..<obfuscatedKey.count {
            deobfuscatedKeyBytes.append(obfuscatedKey[i] ^ xorValue[i % xorValue.count])
        }

        return String(bytes: deobfuscatedKeyBytes, encoding: .utf8) ?? ""
    }
}
