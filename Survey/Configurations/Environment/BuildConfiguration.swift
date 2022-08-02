//
//  BuildConfiguration.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

final class BuildConfiguration {

    static let shared = BuildConfiguration()

    var environment: Environment = .development

    init() {
        guard let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String else {
            return
        }

        environment = Environment(rawValue: currentConfiguration) ?? .development
    }
}
