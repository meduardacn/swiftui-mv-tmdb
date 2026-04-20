//
//  URLRequestBuilder.swift
//  MovieDB
//
//  Created by Maria Eduarda on 20/04/26.
//

import Foundation

class URLRequestBuilder {
    private var url: URL
    private var method: HTTPMethod = .get()
    private var headers: [String: String] = [:]
    private var body: Data? = nil
    private var timeout: TimeInterval = 60

    init(url: URL) {
        self.url = url
    }

    @discardableResult
    func method(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }

    @discardableResult
    func header(_ key: String, _ value: String) -> Self {
        self.headers[key] = value
        return self
    }

    @discardableResult
    func headers(_ headers: [String: String]) -> Self {
        self.headers.merge(headers) { current, new in new }
        return self
    }

    @discardableResult
    func body(_ data: Data) -> Self {
        self.body = data
        return self
    }

    @discardableResult
    func timeout(_ seconds: TimeInterval) -> Self {
        self.timeout = seconds
        return self
    }

    func build() -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = method.name
        method.payload?.forEach { payload in
            switch payload {
            case .body(let data):
                request.httpBody = data
            case .query(let items):
                request.addQuery(items)
            }
        }
        request.httpBody = body
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        precondition(request.url != nil, "URLRequest must have a valid URL")
        precondition(request.httpMethod != nil, "URLRequest must have an HTTP method")
        precondition(request.timeoutInterval > 0,"Timeout must be positive, got \(request.timeoutInterval)")

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
