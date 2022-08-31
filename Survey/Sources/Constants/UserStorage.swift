//
//  UserStorage.swift
//  Survey
//
//  Created by Khanh on 28/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

enum UserStorage {

    @Storage(key: Constants.UserDefaultKeys.cachedSurveyList, defaultValue: [])

    static var cachedSurveyList: [APISurvey]
}
