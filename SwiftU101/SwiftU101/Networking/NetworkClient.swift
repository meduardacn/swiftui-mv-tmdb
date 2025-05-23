//
//  NetworkClient.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation
import SwiftUI

struct NetworkClient: Sendable {
    private var dataFetcher: DataFetcher

    public init(dataFetcher: DataFetcher = URLSession.shared) {
        self.dataFetcher = dataFetcher
    }

    private func response<Response>(
        for endpoint: Endpoint,
        transform: (Data) throws -> Response
    ) async throws -> Response {
        let request = try await endpoint.request()
        let data = try await dataFetcher.fetch(for: request)
        return try transform(data)
    }

    public func response<Response>(
        for endpoint: Endpoint?
    ) async throws -> Response where Response: Decodable {
        guard let endpoint = endpoint else { throw NetworkError.endpointError }
        return try await response(for: endpoint) { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(Response.self, from: data)
        }
    }

    public func image(
        for endpoint: Endpoint
    ) async throws -> UIImage {
        struct InvalidImageData: Error {
            let data: Data
        }

        return try await response(for: endpoint) { data in
            guard let image = UIImage(data: data) else {
                throw InvalidImageData(data: data)
            }

            return image
        }
    }
}
