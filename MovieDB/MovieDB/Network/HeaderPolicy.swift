//
//  HeaderPolicy.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

public enum APIHeaderKey: String {
    case accept = "accept"
    case authorization = "Authorization"
}

public protocol HeaderPolicy: Sendable {
    func buildHeaders() throws -> [String: String]
}

struct EmptyHeaderPolicy: HeaderPolicy {
    func buildHeaders() throws -> [String: String] { [:] }
}

struct PrimaryPolicy: HeaderPolicy {

    let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func buildHeaders() throws -> [String: String] {
        let headers = [
            APIHeaderKey.accept.rawValue: "application/json",
            APIHeaderKey.authorization.rawValue: "Bearer \(apiKey)"
        ]
        return headers
    }
}

extension HeaderPolicy where Self == EmptyHeaderPolicy {
    static var empty: Self { .init() }
}

extension HeaderPolicy where Self == PrimaryPolicy {
    static var primary: Self {
        @Secret(\.apiKey) var key: String
        return PrimaryPolicy(apiKey: key)
    }
}
