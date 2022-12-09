//
//  SurveyListStorage.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
// swiftlint:disable let_var_whitespace

protocol SurveyListCachable {

    var cachedSurveyList: [APISurvey] { get set }
}

struct SurveyListStorage: SurveyListCachable {

    @Storage(key: Constants.UserDefaultKeys.cachedSurveyList, defaultValue: [])
    var cachedSurveyList: [APISurvey]
}
