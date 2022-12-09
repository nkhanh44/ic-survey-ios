//
//  SelectedAnswer.swift
//  Survey
//
//  Created by Khanh on 28/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct SelectedAnswer {

    var index: Int
    var text: String?
}

extension SelectedAnswer {

    init(index: Int) {
        self.index = index
        text = nil
    }
}
