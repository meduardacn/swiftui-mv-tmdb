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

    func buildUrl() throws -> URL {

        guard let url = URL(string: "https://image.tmdb.org/t/p/original/\(path)") else {
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
    static func imageUrl(path: String) -> Self {
        ImageURLBuilder(path: path)
    }
}
