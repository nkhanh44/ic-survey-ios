//
//  XCUIElement+.swift
//  Survey
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import XCTest

extension XCUIElement {

    func tapThen() -> Self {
        tap()
        return self
    }
}
