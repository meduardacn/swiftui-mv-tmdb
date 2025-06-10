//
//  NowPlaying.swift
//  SwiftU101
//
//  Created by Vinicius Soares on 26/05/25.
//

import SwiftUI

struct NowPlaying: View {

    @Environment(NowPlayingMoviesStore.self) private var store
    @State private var currentPage: Int = 0
    @State private var isLoading: Bool = false
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
            Text("Showing \(movieCount) results")
                .bold()
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            LazyVGrid(
                columns: [.init(), .init()],
                spacing: 22
            ) {
                ForEach(movies) { movie in
                    MovieCard.large(
                        title: movie.title,
                        rate: movie.voteAverage,
                        isFavorited: false,
                        imageURL: movie.posterImageURL
                    )
                    .redacted(reason: isLoading ? .placeholder : [])
                }
            }

            Color.clear
                .onScrollVisibilityChange { isVisible in
                    guard isVisible else { return }
                    Task { await fetchMovies() }
                }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchMovies()
        }
    }

    private func fetchMovies() async {
        guard !isLoading else { return }
        isLoading = true
        let nextPage = currentPage + 1
        await store.fetchMovies(page: nextPage)
        currentPage = nextPage
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        NowPlaying()
            .environment(NowPlayingMoviesStore())
    }
}
