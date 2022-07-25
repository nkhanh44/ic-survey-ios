//
//  CancelBag.swift
//  Survey
//
//  Created by Khanh on 25/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

open class CancelBag {

    public var subscriptions = Set<AnyCancellable>()

    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {

    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
