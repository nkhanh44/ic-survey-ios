//
//  RequestConfiguration.swift
//

import Alamofire
import Foundation

protocol RequestConfigurationType {

    var baseURL: String { get }

    var endpoint: String { get }

    var method: HTTPMethod { get }

    var url: URLConvertible { get }

    var parameters: Parameters? { get }

    var encoding: ParameterEncoding { get }

    var headers: HTTPHeaders? { get }

    var interceptor: RequestInterceptor? { get }
}

struct RequestConfiguration: RequestConfigurationType {

    let baseURL: String = Constants.API.getAPIURL(enviroment: BuildConfiguration.shared.environment)
    let endpoint: String
    let method: HTTPMethod
    let encoding: ParameterEncoding
    let parameters: Parameters?
    var headers: HTTPHeaders?
    var interceptor: RequestInterceptor?

    var url: URLConvertible {
        let url = URL(string: baseURL)?.appendingPathComponent(endpoint)
        return url?.absoluteString ?? "\(baseURL)\(endpoint)"
    }

    init(
        endpoint: String,
        method: HTTPMethod,
        encoding: ParameterEncoding,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
        self.interceptor = interceptor
    }
}

extension RequestConfigurationType {

    var parameters: Parameters? { nil }
    var headers: HTTPHeaders? { nil }
    var interceptor: RequestInterceptor? { nil }
}
