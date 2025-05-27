//
//  MainView.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 26/05/25.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        NavigationStack {
            List {
            }
            .listStyle(.plain)
            .navigationTitle("The MovieDB")
        }
    }
}

#Preview {
    MainView()
        .environment(
            NowPlayingMoviesStore(
//                movieService: MockMoviesService()
            )
        )
        .environment(PopularMoviesStore())
}
