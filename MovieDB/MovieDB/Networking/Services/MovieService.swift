//
//  MovieService.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import Foundation
import SwiftUI
import UIKit

public protocol MoviesService {
    func fetchNowPlayingMovies(page: Int) async throws -> [Movie]
    func fetchPopularMovies(page: Int) async throws -> [Movie]
    func serchMovies(query: String, page: Int) async throws -> [Movie]
    func fetchMovieGenres() async throws -> [Genre]
}

public actor MovieDBMoviesService: MoviesService {
    private let client = NetworkClient()

    public init() {}

    public func fetchMovieGenres() async throws -> [Genre] {
        let response: GenresDTO = try await client.response(for: .fetchMoviesGenres())
        return response.genres.map { Genre(from: $0 ) }
    }
    
    public func fetchNowPlayingMovies(page: Int) async throws -> [Movie] {
        try await fetchMovies(endpoint: .fetchNowPlayingMovies(with: page))
    }
    
    public func fetchPopularMovies(page: Int) async throws -> [Movie] {
        try await fetchMovies(endpoint: .fetchPopularMovies(with: page))
    }
    
    public func serchMovies(query: String, page: Int) async throws -> [Movie] {
        try await fetchMovies(endpoint: .searchMovies(for: query, with: page))
    }

    private func fetchMovies(endpoint: Endpoint) async throws -> [Movie] {
        let genres = try await fetchMovieGenres()
        let response: MoviesDTO = try await client.response(for: endpoint)
        let movieIDs: [Int] = response.results.map { $0.id }

        let movies = response.results
            .map { movieDTO in
                let genres = genres.filter {
                    movieDTO.genre_ids.contains($0.id)
                }

                return Movie(
                    from: movieDTO,
                    imageURL: try? URL(
                        .imageUrl(path: movieDTO.poster_path, maxWidth: 300)
                    ),
                    genres: genres
                )
            }
            .sorted { (a,b) -> Bool in
                if let first = movieIDs.firstIndex(of: a.id),
                   let second = movieIDs.firstIndex(of: b.id) {
                    return first < second
                }
                return false
            }

        return movies
    }

}

extension MoviesService where Self == MovieDBMoviesService {
   public static func shared() -> Self { .init() }
}
