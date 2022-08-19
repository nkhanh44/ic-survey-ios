//
//  NetworkAPI.swift
//

import Alamofire
import Combine
import Foundation

final class NetworkAPI: NetworkAPIProtocol {

    private let decoder: SDecoderType
    private let session = Session(eventMonitors: [AlamofireLogger()])

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
