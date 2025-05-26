//
//  Endpoint.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation

struct Endpoint: Sendable {
    public let url: URLBuilder
    public let headers: HeaderPolicy
    public let method: HTTPMethod

    init(url: URLBuilder, headers: HeaderPolicy, method: HTTPMethod) {
        self.url = url
        self.headers = headers
        self.method = method
    }

    func request() async throws -> URLRequest {
        let url = try url.buildUrl()
        let headers = try headers.generateHeaders()
        var request = URLRequest(url: url)
        request.httpMethod = method.name

        method.payload?.forEach { payload in
            switch payload {
            case .body(let data):
                request.httpBody = data
            case .query(let items):
                request.addQuery(items)
            }
        }

        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }

        return request
    }
}

private extension URLRequest {
    mutating func addQuery(_ queryItems: [URLQueryItem]) {
        guard let url, !queryItems.isEmpty else { return }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

        if let existingQueryItems = components?.queryItems {
            components?.queryItems = existingQueryItems + queryItems
        } else {
            components?.queryItems = queryItems
        }

        guard let updateUrl = components?.url else {
            preconditionFailure("Couldn't create url from components")
        }

        self.url = updateUrl
    }
}
