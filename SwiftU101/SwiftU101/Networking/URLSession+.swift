//
//  URLSession+.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation

public protocol DataFetcher: Sendable {
    @discardableResult
    func fetch(for request: URLRequest) async throws -> Data
}

extension URLSession: DataFetcher {
    public func fetch(for request: URLRequest) async throws -> Data {
        let payload: (Data, URLResponse) = try await data(for: request)

        return try URLSession.validateResponse(for: request, payload: payload)
    }

    static func validateResponse(
        for request: URLRequest,
        payload: (Data, URLResponse)
    ) throws -> Data {
        let (data, response) = payload
        
        debugLog(for: request, payload: payload)

        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidResponse(response)
        }

        guard (200 ..< 300).contains(statusCode) else {
            if statusCode == 401 {
                throw NetworkError.unauthorized
            } else {
                throw NetworkError.invalidError(response, statusCode)
            }
        }

        return data
    }

    static func debugLog(for request: URLRequest, payload: (data: Data, response: URLResponse)) {
        let response = payload.response as? HTTPURLResponse
        let data = payload.data

        let url = response?.url?.absoluteString ?? "UNKNOWN URL"
        let statusCode = response?.statusCode ?? .zero
        let type = request.httpMethod ?? "UNKNOWN TYPE"

        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])

        var stringValue: String?

        if let jsonObject = jsonObject, let mappedData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
            stringValue = String(data: mappedData, encoding: .utf8) ?? "could not parse to json"
        }

        Log.network.debug(
            """
            [Request Logger]
            REQUEST: "\(url)"
            TYPE: "\(type)"
            CODE: "\(statusCode)"

            RESPONSE: "\(stringValue ?? "could not parse to json")"
            """
        )
    }
}
