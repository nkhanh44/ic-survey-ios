//
//  APISurvey+Dummy.swift
//  Survey
//
//  Created by Khanh on 10/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension APISurvey {

    static var dummyList = [
        APISurvey(
            id: "1",
            type: "type1",
            title: "Title1",
            description: "description1",
            coverImageURL: Assets.ic_background_exp_1.name
        ),
        APISurvey(
            id: "2",
            type: "type2",
            title: "Title2",
            description: "description2",
            coverImageURL: Assets.ic_background_exp_2.name
        ),
        APISurvey(
            id: "3",
            type: "type3",
            title: "Title3",
            description: "description3",
            coverImageURL: Assets.ic_background_exp_3.name
        ),
        APISurvey(
            id: "4",
            type: "type4",
            title: "Title4",
            description: "description4",
            coverImageURL: Assets.ic_background_exp_1.name
        ),
        APISurvey(
            id: "5",
            type: "type",
            title: "Title5",
            description: "description5",
            coverImageURL: Assets.ic_background_exp_2.name
        )
    ]
}
