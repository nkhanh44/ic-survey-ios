//
//  AlamofireLogger.swift
//  Survey
//
//  Created by Khanh on 02/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire

final class AlamofireLogger: EventMonitor {

    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        \n
        👍 Request Started: \(request)
        👍 Body Data: \(body)
        \n
        """
        NSLog(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        NSLog("\n⚡️ Response Received: \(response.debugDescription)")
    }
}
