//
//  KeychainAccess.swift
//  Survey
//
//  Created by Khanh on 02/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import KeychainAccess

private enum Keys: String {

    case token = "token_info"
}

enum KeychainAccess {

    private static let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")

    static var token: KeychainToken? {
        get {
            let decoder = JSONDecoder()
            guard let savedToken = keychain[data: Keys.token.rawValue],
                  let token = try? decoder.decode(KeychainToken.self, from: savedToken) else {
                return nil
            }
            return token
        }

        set {
            let encoder = JSONEncoder()
            guard let encoded = try? encoder.encode(newValue) else { return }
            keychain[data: Keys.token.rawValue] = encoded
        }
    }

    static var isLoggedIn: Bool {
        keychain[Keys.token.rawValue] != nil
    }

    static func remove() {
        keychain[Keys.token.rawValue] = nil
    }
}
