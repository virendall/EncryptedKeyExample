#!/usr/bin/env swift

import Foundation
import CryptoKit

// Read secret from environment
let secret = "MY_SUPER_SECRET_API_KEY" 

do {
    let aesKey = SymmetricKey(size: .bits256)
    let data = Data(secret.utf8)
    let sealedBox = try AES.GCM.seal(data, using: aesKey)
    guard let combined = sealedBox.combined else {
        fputs("ERROR: unable to get combined encrypted data\n", stderr)
        exit(1)
    }

    let encryptedBytes = Array(combined)
    let keyBytes = aesKey.withUnsafeBytes { Array($0) }

    let output = """
    // Auto-generated file — DO NOT EDIT
    import Foundation

    struct ProtectedKeys {
        static let encryptedAPIKey: [UInt8] = \(encryptedBytes)
        static let aesKey: [UInt8] = \(keyBytes)
    }
    """

    // Print to stdout (Bash/Run Script will capture this)
    print(output)
} catch {
    fputs("ERROR: \(error)\n", stderr)
    exit(1)
}
