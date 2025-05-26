//
//  NowPlaying.swift
//  SwiftU101
//
//  Created by Vinicius Soares on 26/05/25.
//

import SwiftUI

struct NowPlaying: View {

    @State private var isLoading: Bool = false
    @State private var searchText: String = ""

    private let provider = NowPlayingMoviesRepository()

    private var movies: [Movie] {
        provider.movies
    }

    private var movieCount: Int {
        provider.movies.count
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
                alignment: .leading,
                spacing: 22
            ) {
                ForEach(movies) { movie in
                    MovieCard.large(
                        title: movie.title,
                        rate: movie.voteAverage,
                        isFavorited: false,
                        image: movie.posterImage,
                        onTap: {}
                    )
                    .padding(.horizontal)
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            isLoading = true
            await provider.fetchMovies()
            isLoading = false
        }
    }
}

#Preview {
    NavigationStack {
        NowPlaying()
    }
}
