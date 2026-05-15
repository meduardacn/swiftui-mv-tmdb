//
//  PopularMoviesStore.swift
//  MovieDB
//
//  Created by Vinícius Chagas on 26/05/25.
//

import Observation

@MainActor
@Observable
final class PopularMoviesStore {
    private let movieService: any MoviesService
    private(set) var movies: [Movie] = []

    var isLoading = false
    var storeError: String?

    init(movieService: any MoviesService = .shared()) {
        self.movieService = movieService
    }

    func fetchMovies() async {
        do {
            isLoading = true
            let result = try await movieService.fetchPopularMovies(page: 1)
            self.setMovies(result)
            isLoading = false
        } catch {
            isLoading = false
            storeError = "Failed to fetch popular movies with error: \(error)."
        }
    }

    @MainActor
    private func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }
}
