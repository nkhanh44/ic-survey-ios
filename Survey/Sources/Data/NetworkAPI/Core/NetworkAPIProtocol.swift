//
//  NetworkAPIProtocol.swift
//

import Alamofire
import Combine
import Japx

protocol NetworkAPIProtocol {

    func performRequest<T: Decodable & Encodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Future<T, Error>
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
                            let result = try JSONDecoder().decode(NoReply.self, from: data)
                            guard let res = result.meta as? T else { return }
                            promise(.success(res))
                        }
                    case let .failure(error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }

    func request<T: JapxCodable>(
        session: Session,
        configuration: RequestConfiguration,
        decoder: SDecoderType
    ) -> Future<([T], MetaData), Error> {
        return Future<([T], MetaData), Error> { promise in
            session.request(
                configuration.url,
                method: configuration.method,
                parameters: configuration.parameters,
                encoding: configuration.encoding,
                headers: configuration.headers,
                interceptor: configuration.interceptor
            )
            .responseData { data in
                do {
                    switch data.result {
                    case let .success(data):
                        let result = try JapxDecoder().decode(JapxResponseArray<T>.self, from: data)
                        promise(.success((result.data ?? [], result.meta)))
                    case let .failure(error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
