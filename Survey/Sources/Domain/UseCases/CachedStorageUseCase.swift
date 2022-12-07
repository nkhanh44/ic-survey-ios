//
//  CachedStorageUseCase.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol CachedStorageUseCaseProtocol {

    func store(data: [Survey])
    func load() -> [Survey]
    func delete() -> Observable<Bool>
}

struct CachedStorageUseCase: CachedStorageUseCaseProtocol {

    let storage: StorageProtocol

    init(storage: StorageProtocol = CachedUserStorage.shared) {
        self.storage = storage
    }

    func store(data: [Survey]) {
        storage.set(objects: data)
    }

    func load() -> [Survey] {
        guard let data = storage.get() as? [Survey] else {
            return []
        }
        return data
    }

    func delete() -> Observable<Bool> {
        storage.remove()
        guard let data = storage.get() as? [Survey] else {
            return Just(false).asObservable()
        }
        return Just(data.isEmpty).asObservable()
    }
}
