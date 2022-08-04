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
        #if PROD
            return production
        #else
            return staging
        #endif
    }
}
