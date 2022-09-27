//  Bundle+Version.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Bundle {

    var releaseVersionNumber: String {
        "v" + (infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
    }
}
