//
//  NetworkAPI.swift
//

import Alamofire
import Combine
import Foundation

final class NetworkAPI: NetworkAPIProtocol {

    private let decoder: SDecoderType

    init(decoder: SDecoderType = .japxDecoder) {
        self.decoder = decoder
    }

    func performRequest<T: Decodable & Encodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Future<T, Error> {
        request(
            session: Session(),
            configuration: configuration,
            decoder: decoder
        )
    }
}
