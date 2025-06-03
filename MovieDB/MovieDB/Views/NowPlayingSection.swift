//
//  NowPlayingSection.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import SwiftUI

struct NowPlayingSection: View {

    @Environment(NowPlayingMoviesStore.self)
    private var nowPlayingMoviesStore

    @State private var isLoading: Bool = false

    private var nowPlayingMovies: [Movie] {
        Array(nowPlayingMoviesStore.movies.prefix(10))
    }
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(nowPlayingMovies) { movie in
                        MovieCard.large(
                            title: movie.title,
                            rate: movie.voteAverage,
                            isFavorited: false,
                            imageURL: movie.posterImageURL
                        )
                    }
                }
            }
            .scrollClipDisabled()
        } header: {
            HStack {
                Text("Now Playing")
                if isLoading {
                    ProgressView()
                        .frame(width: 24, height: 8)
                }
                Spacer()
                NavigationLink("See All", destination: NowPlaying())
                    .font(.callout)
            }
        }
        .listSectionSeparator(.hidden)
        .task {
            isLoading = true
            await nowPlayingMoviesStore.fetchMovies()
            isLoading = false
        }
    }
}

#Preview {
    List {
        NowPlayingSection()
            .environment(NowPlayingMoviesStore(movieService: .mock))
    }
    .listStyle(.plain)
}
