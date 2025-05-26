//
//  MockMoviesService.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import Foundation

public class MockMoviesService: MoviesService {
    public typealias NowPlayingMoviesProvider = @Sendable (Int) async throws -> [Movie]
    public typealias PopularMoviesProvider = @Sendable (Int) async throws -> [Movie]
    public typealias SearchMoviesProvider = @Sendable (Int) async throws -> [Movie]
    public typealias MovieGenresProvider = @Sendable () async throws -> [Genre]

    public var providerNowPlayingMovies: NowPlayingMoviesProvider = { _ in [.mock] }
    public var providerPopularMovies: PopularMoviesProvider = { _ in [.mock] }
    public var providerSearchMovies: SearchMoviesProvider = { _ in [.mock] }
    public var providerMovieGenres: MovieGenresProvider = { [.family] }

    public init() {}

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
