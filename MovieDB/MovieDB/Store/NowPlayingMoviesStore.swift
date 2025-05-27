//
//  NowPlayingMoviesRepository.swift
//  SwiftU101
//
//  Created by Vinicius Soares on 26/05/25.
//

import Observation

@Observable
final class NowPlayingMoviesStore {
    
    private(set) var movies: [Movie] = []

    private let movieService: any MoviesService

    init(movieService: any MoviesService = .shared()) {
        self.movieService = movieService
    }

    func fetchMovies() async {
        debugPrint(">>> Fetching now playing movies...")

        do {
            let result = try await movieService.fetchNowPlayingMovies(page: 1)
            await self.setMovies(result)
        } catch {
            debugPrint(">>> Error fetching now playing movies: \(error)")
        }
    }

    @MainActor
    private func setMovies(_ movies: [Movie]) {
        debugPrint(">>> Set now playing movies: \(movies.map(\.title))")
        self.movies = movies
    }
}
