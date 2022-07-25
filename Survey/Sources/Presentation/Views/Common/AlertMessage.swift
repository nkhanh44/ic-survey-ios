//
//  AlertMessage.swift
//  Survey
//
//  Created by Khanh on 25/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

public struct AlertMessage {

    public var title = ""
    public var message = ""
    public var isShowing = false

    public init(title: String, message: String, isShowing: Bool) {
        self.title = title
        self.message = message
        self.isShowing = isShowing
    }

    public init() {}
}

// swiftlint:disable:this no_extension_access_modifier
extension AlertMessage {

    init(error: Error) {
        title = "Error"
        let message = error.localizedDescription
        self.message = message
        isShowing = !message.isEmpty
    }
}
