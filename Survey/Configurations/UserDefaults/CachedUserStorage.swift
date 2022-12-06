//
//  CachedUserStorage.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

final class CachedUserStorage: UserStorageProtocol {

    static let shared = CachedUserStorage(key: Constants.UserDefaultKeys.cachedSurveyList)

    private var storage: Storage<[APISurvey]>

    init(
        key: String,
        defaultValue: [APISurvey] = []
    ) {
        storage = Storage(
            key: key,
            defaultValue: defaultValue
        )
    }

    func get() -> [Any] {
        storage.wrappedValue
    }

    func getValue() -> [APISurvey] {
        get() as? [APISurvey] ?? []
    }

    func set(objects: [Any]) {
        storage.wrappedValue = objects as? [APISurvey] ?? []
    }

    func remove() {
        storage.wrappedValue = []
    }
}
