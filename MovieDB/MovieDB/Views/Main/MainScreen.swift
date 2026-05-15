//
//  MainScreen.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 26/05/25.
//

import SwiftUI

struct MainScreen: View {
    @Environment(AnalyticsManager.self) private var analyticsManager
    @Environment(NowPlayingMoviesStore.self) private var nowPlayingMoviesStore
    @Environment(PopularMoviesStore.self) private var popularMoviesStore
    
    var body: some View {
        ScrollView {
            NowPlayingSection()
            Divider()
            PopularSection()
        }
        .task {
            await popularMoviesStore.fetchMovies()
            await nowPlayingMoviesStore.fetchMovies()
            analyticsManager.track(.screenView(with: "MainScreen"))
        }
        .navigationTitle("The MovieDB")

    }
}

#Preview {
    MainScreen()
        .environment(NowPlayingMoviesStore(movieService: .mock))
        .environment(PopularMoviesStore(movieService: .mock))
        .environment(AnalyticsManager(providers: [FirebaseProvider()]))
}
