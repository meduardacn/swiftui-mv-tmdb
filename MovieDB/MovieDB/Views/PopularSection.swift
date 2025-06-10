//
//  PopularSection.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 26/05/25.
//

import SwiftUI

struct PopularSection: View {

    @Environment(PopularMoviesStore.self)
    private var popularMoviesStore

    @State private var isLoading: Bool = false

    private var nowPlayingMovies: [Movie] {
        Array(popularMoviesStore.movies.prefix(10))
    }

    var body: some View {
        Section {
            VStack(spacing: 12) {
                ForEach(nowPlayingMovies) { movie in
                    MovieCard.small(
                        title: movie.title,
                        description: movie.overview,
                        rate: movie.voteAverage,
                        isFavorited: false,
                        imageURL: movie.posterImageURL
                    )
                }
            }
        } header: {
            HStack {
                Text("Popular")
                if isLoading {
                    ProgressView()
                        .frame(width: 24, height: 8)
                }
            }
        }
        .listSectionSeparator(.hidden)
        .task {
            isLoading = true
            await popularMoviesStore.fetchMovies()
            isLoading = false
        }
    }
}

#Preview {
    List {
        PopularSection()
            .environment(PopularMoviesStore(movieService: .mock))
    }
    .listStyle(.plain)
}
