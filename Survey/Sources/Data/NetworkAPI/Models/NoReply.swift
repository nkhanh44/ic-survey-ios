//
//  NoReply.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct Message: Codable {

    let message: String
}

struct NoReply: Codable {

    let meta: Message
}
