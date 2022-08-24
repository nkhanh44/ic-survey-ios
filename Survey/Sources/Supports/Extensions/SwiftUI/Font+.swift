//
//  UIFont+.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

protocol FontStyle {

    var name: String { get }
}

extension Font {

    private enum NeuzeiStyle: FontStyle {

        case regular
        case bold

        var name: String {
            switch self {
            case .regular:
                return "NeuzeitSLTStd-Book"
            case .bold:
                return "NeuzeitSLTStd-BookHeavy"
            }
        }
    }

    /// Weight: 800, Size: 13.0
    static let smallBoldBody: Font = .neuzei(style: .bold, size: 13.0)

    /// Weight: 800, Size: 15.0
    static let smallBoldTag: Font = .neuzei(style: .bold, size: 15.0)

    /// Weight: 400, Size: 17.0
    static let regularBody: Font = .neuzei()

    /// Weight: 800, Size: 17.0
    static let boldBody: Font = .neuzei(style: .bold)

    /// Weight: 400, Size: 10.0
    static let errorBody: Font = .neuzei(size: 10.0)

    /// Weight: 800, Size: 28.0
    static let boldTitle: Font = .neuzei(style: .bold, size: 28.0)

    /// Weight: 800, Size: 34.0
    static let largeTitle: Font = .neuzei(style: .bold, size: 34.0)

    private static func neuzei(style: NeuzeiStyle = .regular, size: CGFloat = 17.0) -> Font {
        return Font.custom(style.name, size: size)
    }
}
