//
//  SwiftU101App.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI

@main
struct SwiftU101App: App {
    @StateObject var store = Store()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .task {
                    async let popular: () =  store.fetchPopularMovies()
                    async let nowPlaying: () = store.fetchNowPlayingMovies()
                    await popular
                    await nowPlaying
                }
        }
    }
}
