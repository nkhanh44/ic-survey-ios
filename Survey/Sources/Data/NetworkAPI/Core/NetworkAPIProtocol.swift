//
//  NetworkAPIProtocol.swift
//

import Alamofire
import Combine
import Japx

protocol NetworkAPIProtocol {

    func performRequest<T: Decodable & Encodable>(_ configuration: RequestConfiguration) -> Future<T, Error>
    func performEmptyRequest<T: Decodable & Encodable>(_ configuration: RequestConfiguration) -> Future<T, Error>
}

// swiftlint:disable closure_body_length

extension NetworkAPIProtocol {

    func request<T: Decodable & Encodable>(
        session: Session,
        configuration: RequestConfiguration,
        decoder: SDecoderType
    ) -> Future<T, Error> {
        return Future<T, Error> { promise in
            session.request(
                configuration.url,
                method: configuration.method,
                parameters: configuration.parameters,
                encoding: configuration.encoding,
                headers: configuration.headers,
                interceptor: configuration.interceptor
            )
            .validate()
            .responseData { data in
                do {
                    switch data.result {
                    case let .success(data):
                        if decoder == .japxDecoder {
                            let result = try JapxDecoder().decode(JapxResponse<T>.self, from: data)
                            promise(.success(result.data))
                        } else {
                            _ = try JSONDecoder().decode(EmptyJapxResponse<T>.self, from: data)
                            guard let result = EmptyResponse.data as? T else {
                                return
                            }
                            promise(.success(result))
                        }
                    case let .failure(error):
                        guard let data = data.data else {
                            return promise(.failure(error))
                        }
                        promise(.failure(data.errorData))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
