//
//  SurveyRepositorySpec.swift
//  Survey
//
//  Created by Khanh on 28/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
//  swiftlint:disable closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SurveyRepositorySpec: QuickSpec {

    override func spec() {
        var surveyRepository: SurveyRepository!
        var networkAPIMock: NetworkAPIMock!

        describe("a SurveyRepository") {

            beforeEach {
                networkAPIMock = NetworkAPIMock()
                surveyRepository = SurveyRepository(api: networkAPIMock)
            }

            describe("its getSurveyList") {

                let surveyListAPI = APISurvey.dummyList

                beforeEach {
                    networkAPIMock.performRequestReturnValue = Future<[APISurvey], Error> { promise in
                        promise(Result.success(surveyListAPI))
                    }
                }

                it("returns correct response") {
                    _ = surveyRepository.getSurveyList(pageNumber: 1, pageSize: 10)
                        .sink { _ in
                        } receiveValue: {
                            expect($0.count) == surveyListAPI.count
                        }
                }
            }

            describe("its getSurveyList") {

                let detailSurveyAPI = APISurvey.dummyList[0]

                beforeEach {
                    networkAPIMock.performRequestReturnValue = Future<APISurvey, Error> { promise in
                        promise(Result.success(detailSurveyAPI))
                    }
                }

                it("returns correct response") {
                    _ = surveyRepository.getSurveyDetail(id: detailSurveyAPI.id)
                        .sink { _ in
                        } receiveValue: {
                            expect($0.id) == detailSurveyAPI.id
                        }
                }
            }

            describe("its getSurveyList") {

                let id = APISurvey.dummyList[0].id
                let questionSubmissions = [QuestionSubmission]()

                beforeEach {
                    networkAPIMock.performEmptyRequestReturnValue = Future<Bool, Error> { promise in
                        promise(Result.success(true))
                    }
                }

                it("returns correct response") {
                    expect(
                        surveyRepository
                            .submit(id: id, questionSubmissions: questionSubmissions)
                            .compactMap { $0 }
                            .eraseToAnyPublisher()
                    )
                    .to(beAKindOf(AnyPublisher<Bool, Error>.self))
                }
            }
        }
    }
}
