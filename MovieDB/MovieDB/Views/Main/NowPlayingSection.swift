//
//  NowPlayingSection.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import SwiftUI

struct NowPlayingSection: View {
    @Environment(NowPlayingMoviesStore.self) private var nowPlayingMoviesStore

    private var nowPlayingMovies: [Movie] {
        Array(nowPlayingMoviesStore.movies.prefix(10))
    }

    var body: some View {
        BaseSection(
            header: HStack(spacing: 8) {
                Text("Now Playing")
                    .font(.headline)

                Spacer()

                NavigationLink("See All", value: NowPlayingRoute())
                    .font(.callout)
            }
            .padding(.horizontal, 20)
        ) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(nowPlayingMovies) { movie in
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
            .padding(.leading, 20)
            .scrollClipDisabled()
        }
    }
}

#Preview {
    NowPlayingSection()
        .environment(NowPlayingMoviesStore(movieService: .mock))
}
