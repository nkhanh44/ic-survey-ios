//
//  MetaData.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

struct MetaData: Codable {

    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int
}

extension MetaData {

    enum CodingKeys: String, CodingKey {
        case page, pages, records
        case pageSize = "page_size"
    }
}
