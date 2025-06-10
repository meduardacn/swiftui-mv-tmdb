//
//  MainView.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 26/05/25.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        List {
            NowPlayingSection()
            PopularSection()
        }
        .listStyle(.plain)
        .navigationTitle("The MovieDB")

    }
}

#Preview {
    MainView()
        .environment(NowPlayingMoviesStore(movieService: .mock))
        .environment(PopularMoviesStore(movieService: .mock))
}
