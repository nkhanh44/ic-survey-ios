//
//  QuestionSubmissionRepositorySpec.swift
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

final class QuestionSubmissionRepositorySpec: QuickSpec {

    override func spec() {
        var repository: QuestionSubmissionRepository!
        var storage: QuestionSubmissionStorageMock!

        describe("a QuestionSubmissionRepository") {

            beforeEach {
                storage = QuestionSubmissionStorageMock()
                repository = QuestionSubmissionRepository(storage: storage)
            }

            describe("storage calls GetData") {

                let expectedData = QuestionSubmission.dummy

                beforeEach {
                    storage.performGetDataReturnValue = QuestionSubmission.dummy
                    _ = repository.getData()
                }

                it("storage calls GetData") {
                    expect(storage.performGetDataCalled).to(beTrue())
                }

                it("returns correct response") {
                    expect(repository.getData()) == expectedData
                }
            }

            describe("its save") {

                beforeEach {
                    repository.save(data: QuestionSubmission.dummy)
                }

                it("storage calls SetData") {
                    expect(storage.performSetDataCalled).to(beTrue())
                }

                it("returns a correct response") {
                    expect(storage.performSetDataReturnValue) == QuestionSubmission.dummy
                }
            }

            describe("its removeData") {

                beforeEach {
                    storage.performGetDataReturnValue = []
                    _ = repository.removeData()
                }

                it("storage calls SetData") {
                    expect(storage.performSetDataCalled).to(beTrue())
                }

                it("returns a correct response") {
                    let response = repository.removeData()
                    let result = try self.awaitPublisher(response)
                    expect(result) == true
                }
            }
        }
    }
}
