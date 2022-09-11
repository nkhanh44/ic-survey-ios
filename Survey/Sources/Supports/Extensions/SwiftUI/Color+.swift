//
//  Color+.swift
//  Survey
//
//  Created by Khanh on 27/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

extension Color {

    init(hex: Int, opacity: Double = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}

// MARK: - got name from here: https://chir.ag/projects/name-that-color

extension Color {

    /// #15151A
    static let smokeGray = Color(hex: 0x15151A)
    /// #757B83
    static let stoneGray = Color(hex: 0x757B83)
    /// #1E1E1E
    static let grayScale = Color(hex: 0x1E1E1E)
}
