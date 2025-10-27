//
//  MockMoviesService.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import Foundation

public final class MockMoviesService: MoviesService, @unchecked Sendable {
    
    public typealias NowPlayingMoviesProvider = @Sendable (Int) async throws -> [Movie]
    public typealias PopularMoviesProvider = @Sendable (Int) async throws -> [Movie]
    public typealias SearchMoviesProvider = @Sendable (Int) async throws -> [Movie]
    public typealias MovieGenresProvider = @Sendable () async throws -> [Genre]

    public let providerNowPlayingMovies: NowPlayingMoviesProvider
    public let providerPopularMovies: PopularMoviesProvider
    public let providerSearchMovies: SearchMoviesProvider
    public let providerMovieGenres: MovieGenresProvider

    public init(
        providerNowPlayingMovies: @escaping NowPlayingMoviesProvider,
        providerPopularMovies: @escaping PopularMoviesProvider,
        providerSearchMovies: @escaping SearchMoviesProvider,
        providerMovieGenres: @escaping MovieGenresProvider
    ) {
        self.providerNowPlayingMovies = providerNowPlayingMovies
        self.providerPopularMovies = providerPopularMovies
        self.providerSearchMovies = providerSearchMovies
        self.providerMovieGenres = providerMovieGenres
    }

    public convenience init() {
        self.init(
            providerNowPlayingMovies: { _ in [.mock] },
            providerPopularMovies: { _ in [.mock] },
            providerSearchMovies: { _ in [.mock] },
            providerMovieGenres: { [.family] }
        )
    }

    public enum MockMoviesError: Error {
        case failToFetchNowPlayingMovies
        case failToPopularMovies
        case failToSearchMovies
        case failToFetchMovieGenres
    }
    public func fetchNowPlayingMovies(page: Int) async throws -> [Movie] {
        try await providerNowPlayingMovies(page)
    }
    
    public func fetchPopularMovies(page: Int) async throws -> [Movie] {
        try await providerPopularMovies(page)
    }
    
    public func serchMovies(query: String, page: Int) async throws -> [Movie] {
        try await providerSearchMovies(page)
    }
    
    public func fetchMovieGenres() async throws -> [Genre] {
        try await providerMovieGenres()
    }
}

extension MoviesService where Self == MockMoviesService {
    static public var mock: Self { .init() }
}
