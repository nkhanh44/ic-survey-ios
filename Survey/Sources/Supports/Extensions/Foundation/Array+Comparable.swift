//
//  Array+Comparable.swift
//  Survey
//
//  Created by Khanh on 29/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {

    func hasSameChildren(as other: [Element]) -> Bool {
        return count == other.count && sorted() == other.sorted()
    }
}
