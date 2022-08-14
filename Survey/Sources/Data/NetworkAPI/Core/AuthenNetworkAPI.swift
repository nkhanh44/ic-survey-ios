//
//  AuthenNetworkAPI.swift
//  Survey
//
//  Created by Khanh on 17/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire
import Combine

final class AuthenNetworkAPI: NetworkAPIProtocol {

    private let decoder: SDecoderType
    private let session = Session(
        interceptor: AuthenInterceptor(),
        eventMonitors: [
            AlamofireLogger()
        ]
    )

    init(decoder: SDecoderType = .japxDecoder) {
        self.decoder = decoder
    }

    func performRequest<T: Decodable & Encodable>(_ configuration: RequestConfiguration) -> Future<T, Error> {
        request(
            session: session,
            configuration: configuration,
            decoder: decoder
        )
    }
}
