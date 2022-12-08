//
//  SurveyListStorageMock.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

@testable import Survey

final class SurveyListStorageMock: SurveyListCachable {

    var performGetDataCalled = false
    var performSetDataCalled = false
    var performGetDataReturnValue = APISurvey.dummyList

    var cachedSurveyList: [APISurvey] {
        get {
            performGetDataCalled = true
            return performGetDataReturnValue
        }

        set {
            performSetDataCalled = true
        }
    }
}
