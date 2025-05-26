//
//  NowPlayingSection.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import SwiftUI

struct NowPlayingSection: View {
    @EnvironmentObject private var store: Store

    var body: some View {
        BaseSection(
            header: header,
            content: {
                content
            }
        )
        .padding(.horizontal, 20)
        //        switch store.nowPlayingState {
        //        case .loading:
        //            ProgressView()
        //        case .complete(.success):
        //
        //        case .complete(.failure):
        //            Text("Looks like an error occurred. Please try again later.")
        //        }
    }

    var header: some View {
        HStack {
            Text("Now Playing")
                .font(.system(.body, weight: .semibold))
            Spacer()
            Button {
                print("SEE ALL")
            } label: {
                Text("See All")
                    .font(.system(.body))
                    .foregroundColor(.gray)
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        if let movies = store.nowPlayingMovies {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(movies) { movie in
                        MovieCard.large(
                            title: movie.title,
                            rate: movie.voteAverage,
                            isFavorited: false,
                            image: movie.posterImage) {
                                print("SEE DETAILS")
                            }
                    }
                }
            }
        }
    }
}


@MainActor
struct NowPlayingSection_previews: PreviewProvider {
    static var previews: some View {
        let mockService = MockMoviesService()
        mockService.providerNowPlayingMovies = { _ in [.mock, .mock, .mock] }
        let mockStore = Store(moviesService: mockService)

        Task {
            await mockStore.fetchNowPlayingMovies()
        }

        return NowPlayingSection()
            .environmentObject(mockStore)
    }
}

