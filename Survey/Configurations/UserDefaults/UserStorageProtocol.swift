//
//  UserStorageProtocol.swift
//  Survey
//
//  Created by Khanh on 28/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol UserStorageProtocol: AnyObject {

    func get() -> [Any]
    func set(objects: [Any])
    func remove()
}
