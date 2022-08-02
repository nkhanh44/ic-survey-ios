//
//  Token.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Token {

    var id: String { get }
    var type: String { get }
    var accessToken: String { get }
    var tokenType: String { get }
    var expiresIn: Int { get }
    var refreshToken: String { get }
    var createdAt: TimeInterval { get }
}
