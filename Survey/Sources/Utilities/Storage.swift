//
//  Storage.swift
//  Survey
//
//  Created by Khanh on 28/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {

    let userDefaults: UserDefaults
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            if let data = userDefaults.data(forKey: key) {
                if let value = try? JSONDecoder().decode(T.self, from: data) {
                    return value
                }
            }
            return defaultValue
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults.set(data, forKey: key)
            }
        }
    }

    init(
        userDefaults: UserDefaults = UserDefaults.standard,
        key: String,
        defaultValue: T
    ) {
        self.userDefaults = userDefaults
        self.key = key
        self.defaultValue = defaultValue
    }
}
