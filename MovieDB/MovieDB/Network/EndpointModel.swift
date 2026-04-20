//
//  Endpoint.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation

public struct Endpoint: Sendable {
    private let url: URLBuilder
    private let headers: HeaderPolicy
    private let method: HTTPMethod
    private var timeout: TimeInterval

    init(url: URLBuilder, headers: HeaderPolicy, method: HTTPMethod, timeout: TimeInterval = 60) {
        self.url = url
        self.headers = headers
        self.method = method
        self.timeout = timeout
    }

    func request() async throws -> URLRequest {
        let request = URLRequestBuilder(url: try url.buildUrl())
            .method(method)
            .headers(try headers.buildHeaders())
            .timeout(timeout)
            .build()
        
        return request
    }
}


