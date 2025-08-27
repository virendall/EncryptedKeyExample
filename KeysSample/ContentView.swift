//
//  ContentView.swift
//  KeysSample
//
//  Created by Virender on 27/08/25.
//

import SwiftUI
//func printKey() {
//    let encrypted = ProtectedKeys.encryptedAPIKey
//    let key = ProtectedKeys.aesKey
//    print("Encrypted API Key: \(encrypted)")
//    print("AES Key: \(key)")
//}
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "key.horizontal")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(GeneratedKey.getAPIKey() ??  "Key not found")")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
