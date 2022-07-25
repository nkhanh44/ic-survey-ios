//
//  UIFont+.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import UIKit

protocol FontStyle {

    var name: String { get }
}

extension UIFont {

    enum NeuzeiStyle: FontStyle {

        case regular
        case bold

        var name: String {
            switch self {
            case .regular:
                return "NeuzeitBook"
            case .bold:
                return "NeuzeitHeavy"
            }
        }
    }

    static func neuzei(style: NeuzeiStyle = .regular, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: style.name, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
