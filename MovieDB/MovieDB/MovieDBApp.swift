//
//  MovieDBApp.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI

@main
struct MovieDBApp: App {

    init() {
        URLCache.shared.memoryCapacity = 300_000_000 // ~10 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(NowPlayingMoviesStore())
                .environment(PopularMoviesStore())
                .environment(AnalyticsManager())
        }
    }
}
