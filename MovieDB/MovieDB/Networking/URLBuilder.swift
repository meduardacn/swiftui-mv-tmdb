//
//  URLBuilder.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation


public protocol URLBuilder: Sendable {
    func buildUrl() throws -> URL
}

struct BaseURLBuilder: URLBuilder {
    let path: String

    func buildUrl() throws -> URL {

        guard let url = URL(string: "https://api.themoviedb.org/3/\(path)") else {
            throw NetworkError.invalidUrl
        }
        return url
    }
}

struct ImageURLBuilder: URLBuilder {
    let path: String
    let maxWidth: Int   // A value of 0 fetches the original resource

    func buildUrl() throws -> URL {
        let size = maxWidth > 0 ? "w\(maxWidth)" : "original"
        guard let url = URL(string: "https://image.tmdb.org/t/p/\(size)/\(path)") else {
            throw NetworkError.invalidUrl
        }
        return url
    }
}

extension URLBuilder where Self == BaseURLBuilder {
    static func url(path: String) -> Self {
        BaseURLBuilder(path: path)
    }
}

extension URLBuilder where Self == ImageURLBuilder {
    static func imageUrl(path: String, maxWidth: Int = 0) -> Self {
        ImageURLBuilder(path: path, maxWidth: maxWidth)
    }
}

extension URL {

    init(_ urlBuilder: URLBuilder) throws {
        self = try urlBuilder.buildUrl()
    }
}
