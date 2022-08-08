//
//  AlertMessage.swift
//  Survey
//
//  Created by Khanh on 25/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire
import Combine

public struct AlertMessage {

    public var title = ""
    public var message = ""

    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    public init() {}
}

// swiftlint:disable:this no_extension_access_modifier
extension AlertMessage {

    init(error: Error) {
        title = "Error"
        if let sError = error as? SError {
            message = sError.detail
        } else {
            message = error.asAFError?.underlyingError?.localizedDescription ?? ""
        }
    }
}
