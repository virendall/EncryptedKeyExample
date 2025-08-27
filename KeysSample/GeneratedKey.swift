// This file is a placeholder and will be generated automatically at build time. Do not edit manually.

import Foundation
import CryptoKit

final class GeneratedKey {
    static func getAPIKey() -> String? {
        let keyData = Data(ProtectedKeys.aesKey)
        let symKey = SymmetricKey(data: keyData)
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: Data(ProtectedKeys.encryptedAPIKey))
            let decrypted = try AES.GCM.open(sealedBox, using: symKey)
            return String(data: decrypted, encoding: .utf8)
        } catch {
            print("Failed to decrypt API key: \(error)")
            return nil
        }
    }
}
