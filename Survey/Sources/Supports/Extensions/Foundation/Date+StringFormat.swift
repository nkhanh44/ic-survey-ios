//
//  Date+StringFormat.swift
//  Survey
//
//  Created by Khanh on 12/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Date {

    func convertToSurveyDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd"
        return dateFormatter.string(from: self).uppercased()
    }
}
