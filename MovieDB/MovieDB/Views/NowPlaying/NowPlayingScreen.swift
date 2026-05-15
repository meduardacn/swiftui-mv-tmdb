//
//  NowPlayingScreen.swift
//  SwiftU101
//
//  Created by Vinicius Soares on 26/05/25.
//

import SwiftUI

struct NowPlayingScreen: View {
    @Environment(NowPlayingMoviesStore.self) private var store
    @State private var searchText: String = ""

    private var movies: [Movie] {
        store.movies.filter {
            searchText.isEmpty ||
            $0.title.lowercased().contains(searchText.lowercased())
        }
    }

    private var movieCount: Int {
        store.movies.count
    }

    var body: some View {
        ScrollView {
            BaseSection(
                header: Text("Showing \(movieCount) results")
                    .bold()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            ) {
                LazyVGrid(
                    columns: [.init(), .init()],
                    spacing: 22
                ) {
                    ForEach(movies) { movie in
                        NavigationLink(value: MovieDetailRoute(movie: movie)) {
                            MovieCard.large(
                                title: movie.title,
                                rate: movie.voteAverage,
                                isFavorited: false,
                                imageURL: movie.posterImageURL
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()

            Color.clear
                .onScrollVisibilityChange { isVisible in
                    guard isVisible else { return }
                    //TODO: add pagination
                    // Task { await fetchMovies() }
                }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    NavigationStack {
        NowPlayingScreen()
            .environment(NowPlayingMoviesStore(movieService: .mock))
    }
}
