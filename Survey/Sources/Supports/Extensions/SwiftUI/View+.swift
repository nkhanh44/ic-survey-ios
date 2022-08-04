//
//  View+.swift
//  Survey
//
//  Created by Khanh on 05/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

extension View {

    func hidden(_ shouldHide: Bool) -> some View {
        return opacity(shouldHide ? 0 : 1)
    }
}
