//  swiftlint:disable:this file_name
//
//  Typealiases.swift
//

import Combine
import UIKit

typealias AlertCompletion = (UIAlertAction) -> Void

typealias Observable<T> = AnyPublisher<T, Error>

typealias CancelBag = Set<AnyCancellable>
