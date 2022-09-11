//
//  User.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol User {

    var id: String { get }
    var type: String { get }
    var email: String { get }
    var name: String { get }
    var avatarUrl: String { get }
}
