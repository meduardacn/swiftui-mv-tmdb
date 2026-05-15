//
//  PopularSection.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 26/05/25.
//

import SwiftUI

struct PopularSection: View {
    @Environment(PopularMoviesStore.self) private var popularMoviesStore

    private var popularMovies: [Movie] {
        Array(popularMoviesStore.movies.prefix(10))
    }

    var body: some View {
        BaseSection(
            header: VStack(alignment: .leading, spacing: 12) {
                Text("Popular")
                    .font(.headline)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        ) {
            VStack(spacing: 12) {
                ForEach(popularMovies) { movie in
                    NavigationLink(value: MovieDetailRoute(movie: movie)) {
                        MovieCard.small(
                            title: movie.title,
                            description: movie.overview,
                            rate: movie.voteAverage,
                            isFavorited: false,
                            imageURL: movie.posterImageURL
                        )
                    }
                    .navigationLinkIndicatorVisibility(.hidden)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    PopularSection()
        .environment(PopularMoviesStore(movieService: .mock))
}
