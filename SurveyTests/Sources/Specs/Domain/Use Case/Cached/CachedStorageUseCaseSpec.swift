//
//  CachedStorageUseCaseSpec.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
// swiftlint:disable closure_body_length

import Combine
import Nimble
import Quick
@testable import Survey

final class CachedStorageUseCaseSpec: QuickSpec {

    override func spec() {
        var useCase: CachedStorageUseCaseProtocol!
        var repository: CachedRepositoryMock!

        describe("a CachedStorageUseCase") {

            beforeEach {
                repository = CachedRepositoryMock()
                useCase = CachedStorageUseCase(cachedRepository: repository)
            }

            describe("its store called") {

                let expectedData = APISurvey.dummyList

                beforeEach {
                    _ = useCase.store(
                        data: APISurvey.dummyList
                    )
                }

                it("repository calls save") {
                    expect(repository.saveCalled) == true
                }

                it("repository calls save with correct data argument") {
                    expect(repository.dataArgument as? [APISurvey]) == expectedData
                }
            }

            describe("its load called") {

                let expectedData = APISurvey.dummyList

                beforeEach {
                    _ = useCase.load()
                }

                it("repository calls getData") {
                    expect(repository.getDataCalled) == true
                }

                it("repository calls getData with correct response") {
                    expect(repository.getDataReturnValue) == expectedData
                }
            }

            describe("its delete called") {

                beforeEach {
                    _ = useCase.delete()
                }

                it("repository calls removeData") {
                    expect(repository.removeDataCalled) == true
                }

                it("repository calls removeData with correct response") {
                    let response = repository.removeData()
                    let result = try self.awaitPublisher(response)
                    expect(result) == true
                }
            }
        }
    }
}
