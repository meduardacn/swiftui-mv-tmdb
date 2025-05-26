//
//  Store.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import SwiftUI

@MainActor
public class Store: ObservableObject {
    @Published public var nowPlayingState: ViewState<Void> = .loading
    @Published public var nowPlayingMovies: [Movie]?
    private var nowPlayingPage = 1


    @Published public var popularState: ViewState<Void> = .loading
    @Published public var popularMovies: [Movie]?
    private var popularPage = 1

    private var moviesService: any MoviesService

    init(moviesService: MoviesService = .shared()) {
        self.moviesService = moviesService
    }

    public func fetchNowPlayingMovies() async {
        do {
            nowPlayingState = .loading
            nowPlayingMovies = try await moviesService.fetchNowPlayingMovies(page: nowPlayingPage)
            nowPlayingState = .complete
        } catch {
            nowPlayingState = .complete(error)
        }
    }

    public func fetchPopularMovies() async {
        do {
            popularState = .loading
            popularMovies = try await moviesService.fetchPopularMovies(page: popularPage)
            popularState = .complete
        } catch {
            popularState = .complete(error)
        }
    }
}
