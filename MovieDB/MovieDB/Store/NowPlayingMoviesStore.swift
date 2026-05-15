//
//  NowPlayingMoviesRepository.swift
//  SwiftU101
//
//  Created by Vinicius Soares on 26/05/25.
//

import Observation

@MainActor
@Observable
final class NowPlayingMoviesStore {
    private let movieService: any MoviesService
    private(set) var movies: [Movie] = []

    var isLoading = false
    var storeError: String?

    init(movieService: any MoviesService = .shared()) {
        self.movieService = movieService
    }

    func fetchMovies(page: Int = 1) async {
        do {
            isLoading = true
            let result = try await movieService.fetchNowPlayingMovies(page: page)
            self.setMovies(result)
            isLoading = false
        } catch {
            isLoading = false
            storeError = "Failed to fetch now playing movies with error: \(error)"
        }
    }

    private func setMovies(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }
}
