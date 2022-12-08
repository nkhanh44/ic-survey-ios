//
//  QuestionSubmissionStorageMock.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

@testable import Survey

final class QuestionSubmissionStorageMock: QuestionSubmissionCachable {

    var performGetDataCalled = false
    var performSetDataCalled = false
    var performGetDataReturnValue = QuestionSubmission.dummy
    var performSetDataReturnValue = [QuestionSubmission]()

    var questionsSubmission: [QuestionSubmission] {
        get {
            performGetDataCalled = true
            return performGetDataReturnValue
        }

        set {
            performSetDataReturnValue = newValue
            performSetDataCalled = true
        }
    }
}
