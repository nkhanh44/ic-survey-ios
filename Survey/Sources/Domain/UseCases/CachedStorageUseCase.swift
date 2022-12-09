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

    let cachedRepository: CachedRepositoryProtocol

    func store(data: [Survey]) {
        cachedRepository.save(data: data)
    }

    func load() -> [Survey] {
        cachedRepository.getData()
    }

    func delete() -> Observable<Bool> {
        cachedRepository.removeData()
    }
}
