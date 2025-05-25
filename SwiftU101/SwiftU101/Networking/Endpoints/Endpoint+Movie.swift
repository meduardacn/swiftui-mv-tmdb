//
//  Endpoint+Movie.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation

extension Endpoint {
    static func fetchNowPlayingMovies(with page: Int) -> Endpoint {
        let language = URLQueryItem(name: "language", value: "en-US")
        let page = URLQueryItem(name: "page", value: "\(page)")
        return Endpoint(
            url: .url(path: "movie/now_playing"),
            headers: .primary,
            method: .get([.query([language, page])])
        )
    }

    static func fetchPopularMovies(with page: Int) -> Endpoint {
        let language = URLQueryItem(name: "language", value: "en-US")
        let page = URLQueryItem(name: "page", value: "\(page)")
        return Endpoint(
            url: .url(path: "movie/popular"),
            headers: .primary,
            method: .get([.query([language, page])])
        )
    }

    static func fetchMovieDetails(with movieId: Int) -> Endpoint {
        let language = URLQueryItem(name: "language", value: "en-US")
        return Endpoint(
            url: .url(path: "movie/\(movieId)"),
            headers: .primary,
            method: .get([.query([language])])
        )
    }

    static func searchMovies(for query: String, with page: Int) -> Endpoint {
        let query = URLQueryItem(name: "query", value: "\(query)")
        let language = URLQueryItem(name: "language", value: "en-US")
        let adults = URLQueryItem(name: "include_adult", value: "false")
        let page = URLQueryItem(name: "page", value: "\(page)")
        return Endpoint(
            url: .url(path: "search/movie"),
            headers: .primary,
            method: .get([.query([query, language, adults, page])])
        )
    }

    static func fetchMoviesGenres() -> Endpoint {
        return Endpoint(
            url: .url(path: "genre/movie/list"),
            headers: .primary,
            method: .get()
        )
    }
    
}
