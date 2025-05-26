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
        let genres = try await fetchMovieGenres() // TODO: this can be improved
        let response: MoviesDTO = try await client.response(for: endpoint)
        let moviesIDs: [Int] = response.results.map { $0.id }

        return try await withThrowingTaskGroup(of: Movie.self) { group in
            var movies = [Movie]()
            movies.reserveCapacity(response.results.count)

            for movieDTO in response.results {
                group.addTask {
                    async let image: UIImage = self.client.image(for: .fetchImage(filePath: movieDTO.poster_path))
                    let genres: [Genre] = genres.filter { movieDTO.genre_ids.contains($0.id) }
                    return Movie(from: movieDTO, image: Image(uiImage: try await image), genres: genres)
                }
            }

            for try await movie in group {
                movies.append(movie)
            }

            movies = movies.sorted { (a,b) -> Bool in
                if let first = moviesIDs.firstIndex(of: a.id),
                   let second = moviesIDs.firstIndex(of: b.id) {
                    return first < second
                }
                return false
            }

            return movies
        }
    }

}

extension MoviesService where Self == MovieDBMoviesService {
   public static func shared() -> Self { .init() }
}
