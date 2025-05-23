//
//  Endpoint+Movie.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation

extension Endpoint {
    static func fetchNowPlayingMovies(page: Int) -> Endpoint {
        let language = URLQueryItem(name: "language", value: "en-US")
        let page = URLQueryItem(name: "page", value: "\(page)")
        return Endpoint(
            url: .url(path: "movie/now_playing"),
            headers: .primary,
            method: .get([.query([language, page])])
        )
    }

    static func fetchPopularMovies(page: Int) -> Endpoint {
        let language = URLQueryItem(name: "language", value: "en-US")
        let page = URLQueryItem(name: "page", value: "\(page)")
        return Endpoint(
            url: .url(path: "movie/popular"),
            headers: .primary,
            method: .get([.query([language, page])])
        )
    }

    static func fetchMovieDetails(movieId: Int) -> Endpoint {
        let language = URLQueryItem(name: "language", value: "en-US")
        return Endpoint(
            url: .url(path: "movie/\(movieId)"),
            headers: .primary,
            method: .get([.query([language])])
        )
    }
}
