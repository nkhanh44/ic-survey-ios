//
//  AFRequest.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire

public protocol AFRequest: AnyObject {

    @discardableResult
    func cancel() -> Self
}

extension Alamofire.Request: AFRequest {}
