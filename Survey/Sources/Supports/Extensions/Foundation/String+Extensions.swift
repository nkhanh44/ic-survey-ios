//
//  String+Extensions.swift
//  Survey
//
//  Created by Khanh on 04/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension String {

    var isEmailValid: Bool {
        let regexString = "^([a-zA-Z0-9][\\w\\.\\+\\-]*)@([\\w.\\-]+\\.+[\\w]{2,})$"
        return validate(withRegex: regexString)
    }

    var isPasswordValid: Bool {
        count >= 8
    }

    func validate(withRegex regexString: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regexString)
            let result = regex.firstMatch(in: self,
                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                          range: NSRange(location: 0, length: count)) != nil
            return result
        } catch {
            return false
        }
    }
}
