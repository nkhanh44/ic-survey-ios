//
//  CachedRepositorySpec.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
// swiftlint:disable all

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class CachedRepositorySpec: QuickSpec {

    override func spec() {
        var repository: CachedRepository!
        var storage: SurveyListStorageMock!

        describe("a CachedRepository") {

            beforeEach {
                storage = SurveyListStorageMock()
                repository = CachedRepository(surveyListStorage: storage)
            }

            describe("its getData") {

                let expectedData = APISurvey.dummyList

                beforeEach {
                    storage.performGetDataReturnValue = APISurvey.dummyList
                    _ = repository.getData()
                }

                it("gets called") {
                    expect(storage.performGetDataCalled).to(beTrue())
                }

                it("returns correct response") {
                    expect(repository.getData() as? [APISurvey]) == expectedData
                }
            }

            describe("its save") {

                beforeEach {
                    repository.save(data: APISurvey.dummyList)
                }

                it("gets called") {
                    expect(storage.performSetDataCalled).to(beTrue())
                }

                it("returns a correct response") {
                    expect(storage.performSetDataReturnValue) == APISurvey.dummyList
                }
            }

            describe("its removeData") {

                beforeEach {
                    storage.performGetDataReturnValue = []
                    _ = repository.removeData()
                }

                it("gets called") {
                    expect(storage.performSetDataCalled).to(beTrue())
                }

                it("returns correct response") {
                    _ = repository.removeData()
                        .sink { _ in
                        } receiveValue: {
                            expect($0) == true
                        }
                }
            }
        }
    }
}
