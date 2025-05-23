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
    func generateHeaders() throws -> [String: String]
}

struct PrimaryPolicy: HeaderPolicy {

    let apiKey: String

    // TODO: add Secrets
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func generateHeaders() throws -> [String: String] {
        let headers = [
            APIHeaderKey.accept.rawValue: "application/json",
            APIHeaderKey.authorization.rawValue: "Bearer \(apiKey)"
        ]
        return headers
    }
}

extension HeaderPolicy where Self == PrimaryPolicy {
    static var primary: Self {
        PrimaryPolicy(apiKey: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZmUzYmU1NDA0MDJiMDZlMzVmMzg0YmQ3YTJmNDJlMyIsIm5iZiI6MTc0Nzk0OTQ4MS40NDEsInN1YiI6IjY4MmY5N2E5N2NmZDRjNWU5YjA1NDFlNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4Ep2zoWsTnrmFZE0UVlu3jcbvHmr71nSZQXST1I97nU")
    }
}
