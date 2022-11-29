//
//  Encodable.swift
//  Survey
//
//  Created by Khanh on 28/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Encodable {

    var asParameters: [String: Any]? {
        let encoder = JSONEncoder()
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String: Any]
    }
}
