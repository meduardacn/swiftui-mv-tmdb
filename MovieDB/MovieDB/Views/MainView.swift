//
//  MainView.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 26/05/25.
//

import SwiftUI

struct MainView: View {
    @Environment(AnalyticsManager.self) var analyticsManager

    var body: some View {
        List {
            NowPlayingSection()
            PopularSection()
        }
        .task {
            analyticsManager.track(.screenView(with: "MainView"))
        }
        .listStyle(.plain)
        .navigationTitle("The MovieDB")

    }
}

#Preview {
    MainView()
        .environment(NowPlayingMoviesStore(movieService: .mock))
        .environment(PopularMoviesStore(movieService: .mock))
        .environment(AnalyticsManager(provider: FirebaseProvider()))
}
