//
//  PopularMoviesStore.swift
//  MovieDB
//
//  Created by Vinícius Chagas on 26/05/25.
//

import Observation

@Observable
final class PopularMoviesStore {
    private(set) var movies: [Movie] = []

    private let movieService: any MoviesService

    init(movieService: any MoviesService = .shared()) {
        self.movieService = movieService
    }

    func fetchMovies() async {
        debugPrint(">>> Fetching popular movies...")

        do {
            let result = try await movieService.fetchPopularMovies(page: 1)
            await self.setMovies(result)
        } catch {
            debugPrint(">>> Error fetching popular movies: \(error)")
        }
    }

    @MainActor
    private func setMovies(_ movies: [Movie]) {
        debugPrint(">>> Set popular movies: \(movies.map(\.title))")
        self.movies = movies
    }
}
