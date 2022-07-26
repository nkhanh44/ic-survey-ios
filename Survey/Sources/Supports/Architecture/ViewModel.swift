//
//  ViewModel.swift
//  Survey
//
//  Created by Khanh on 25/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

public protocol ViewModel {

    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
