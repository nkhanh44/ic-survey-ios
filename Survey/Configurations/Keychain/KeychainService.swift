//
//  KeychainService.swift
//  Survey
//
//  Created by Khanh on 02/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import KeychainAccess

protocol KeychainServiceProtocol: AnyObject {

    func get(key: KeychainKeys) throws -> KeychainToken?
    func set(newToken: KeychainToken?, for key: KeychainKeys) throws
    func removeToken(with key: KeychainKeys) throws
    func isLoggedIn() throws -> Bool
}

final class KeychainService: KeychainServiceProtocol {

    static let shared = KeychainService(service: Bundle.main.bundleIdentifier ?? "")

    private let keychain: KeychainAccess.Keychain

    init(service: String) {
        keychain = KeychainAccess.Keychain(service: service)
    }

    func get(key: KeychainKeys) throws -> KeychainToken? {
        try keychain
            .getData(key.rawValue)
            .map { try JSONDecoder().decode([KeychainToken].self, from: $0) }?
            .first
    }

    func set(newToken: KeychainToken?, for key: KeychainKeys) throws {
        guard let token = try? JSONEncoder().encode([newToken]) else { return }
        try keychain.set(token, key: key.rawValue)
    }

    func isLoggedIn() throws -> Bool {
        try keychain.get(KeychainKeys.token.rawValue) != nil
    }

    func removeToken(with key: KeychainKeys) throws {
        try keychain.remove(key.rawValue)
    }
}
