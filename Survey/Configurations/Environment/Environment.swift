//
//  Environment.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

enum Environment {

    static func based<T>(staging: T, production: T) -> T {
        #if DEBUG
            return production
        #else
            return staging
        #endif
    }
}
