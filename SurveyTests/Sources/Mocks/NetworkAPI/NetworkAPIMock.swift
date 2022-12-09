//
//  NetworkAPIMock.swift
//  Survey
//
//  Created by Khanh on 29/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
//  swiftlint:disable force_cast

import Combine
import Foundation

@testable import Survey

final class NetworkAPIMock: NetworkAPIProtocol {

    var performRequestCalled = false
    var performRequestReturnValue: Any!

    var performEmptyRequestCalled = false
    var performEmptyRequestReturnValue: Any!

    func performEmptyRequest<T>(_ configuration: RequestConfiguration)
        -> Future<T, Error> where T: Decodable, T: Encodable {
        performEmptyRequestCalled = true
        return performEmptyRequestReturnValue as! Future<T, Error>
    }

    func performRequest<T>(_ configuration: RequestConfiguration)
        -> Future<T, Error> where T: Decodable, T: Encodable {
        performRequestCalled = true
        return performRequestReturnValue as! Future<T, Error>
    }
}
