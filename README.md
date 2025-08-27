# 🔐 KeysSample — Secure API Key Storage in iOS

## 📖 Overview

`EncryptedKeyExample` is a demonstration iOS app that shows how to **securely embed API keys** in an iOS application using **AES-256 GCM compile-time encryption**.  

Instead of storing secrets in plaintext, the app:
1. Encrypts API keys at **build time** using a Swift script
2. Stores the encrypted bytes and AES key in a Swift file
3. Decrypts the key only **at runtime** when it is required

This technique ensures that sensitive values like API keys will not appear in plaintext inside the app bundle or binary, making it harder for attackers to retrieve them using simple tools like `strings`.

---

## ⚡ Features

- 🔒 **AES-256 GCM encryption** for strong protection
- 🛠 **Automatic encryption step** using an Xcode Run Script Phase
- 🧑‍💻 **Runtime decryption** using Apple's CryptoKit
- 🚫 **No plaintext secrets** in source code or final binary
- 📦 **Auto-generated Swift file** containing encrypted values

---

## 🔨 Setup

### 1. Add Your API Key

Edit `Scripts/generate_protected_keys.swift` and replace the placeholder secret:

```swift
let secret = "MY_SUPER_SECRET_API_KEY"
```

with your real API key.

### 2. Make the Script Executable

Open Terminal in your project root and run:

```bash
chmod +x Scripts/generate_protected_keys.swift
```

### 3. Configure Xcode Build Phase

1. In Xcode, select your project → Target → **Build Phases**
2. Click `+` → *New Run Script Phase*
3. Add this command:

```bash
#!/bin/bash
set -euo pipefail
SCRIPT="${SRCROOT}/Scripts/generate_protected_keys.swift"
OUTDIR="${SRCROOT}/Generated"
OUTFILE="${OUTDIR}/ProtectedKeys.swift"
# Use /tmp for the temporary file to avoid sandbox issues
TMPFILE="/tmp/ProtectedKeys.tmp.swift"
 # Ensure output directory exists
 mkdir -p "$OUTDIR"

 # Run the Swift script and capture stdout to a temp file
 xcrun --sdk macosx swift "$SCRIPT" > "$TMPFILE"

 # Set safe perms for tmp file
 chmod 644 "$TMPFILE"

 # Atomically overwrite the placeholder file inside your
mv -f "$TMPFILE" "$OUTFILE"

 # Ensure timestamp changed so Xcode notices
 touch "$OUTFILE"

 echo "✅ ProtectedKeys generated at:  $OUTFILE" >&2
```

Now, every time you build the project, the script will generate `ProtectedKeys.swift` automatically.

### 4. Build & Run

- Clean and build the project (`⌘⇧K` then `⌘B`)
- On first build, `ProtectedKeys.swift` will be generated inside your app source folder
- Run the app → the decrypted API key will print to the Xcode debug console

---

## 🧑‍💻 Usage Example

Inside the app, retrieve the API key like this:

```swift
let apiKey = GeneratedKey.getAPIKey()
print("🔑 API Key: \(apiKey ?? "Error")")
```

This ensures the key is decrypted **only when needed**.

---
