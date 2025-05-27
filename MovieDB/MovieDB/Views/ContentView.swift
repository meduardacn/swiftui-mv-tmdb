//
//  ContentView.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI
import UIKit

struct ContentView: View {

    var body: some View {
        NavigationStack {
            MainView()
        }
    }
}

#Preview {
    ContentView()
        .environment(NowPlayingMoviesStore(movieService: .mock))
        .environment(PopularMoviesStore(movieService: .mock))
}
