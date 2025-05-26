//
//  NowPlayingMoviesRepository.swift
//  SwiftU101
//
//  Created by Vinicius Soares on 26/05/25.
//

import Observation

@Observable
final class NowPlayingMoviesRepository {
    
    private(set) var movies: [Movie]

    private let movieService: MoviesService = .shared()

    init(movies: [Movie] = []) {
        self.movies = movies
    }

    func fetchMovies() async {
        debugPrint(">>> Fetching movies...")

        do {
            let result = try await movieService.fetchNowPlayingMovies(page: 1)
            await self.setMovies(result)
        } catch {
            debugPrint(">>> Error fetching movies: \(error)")
        }
    }

    @MainActor
    private func setMovies(_ movies: [Movie]) {
        debugPrint(">>> Set movies: \(movies)")
        self.movies = movies
    }
}
