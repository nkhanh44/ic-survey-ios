//  swiftlint:disable:this file_name
//  DataResponse.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct JapxResponse<T: Codable>: Codable {

    let data: T
}

struct JapxResponseArray<T: Codable>: Codable {

    var data: [T]?
    var meta: MetaData
}
