//
//  ContentView.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI

struct AppFlow: View {

    var body: some View {
        NavigationStack {
            MainScreen()
                .navigationDestination(for: MovieDetailRoute.self) { route in
                    DetailsScreen(movie: route.movie)
                }
                .navigationDestination(for: NowPlayingRoute.self) { _ in
                    NowPlayingScreen()
                }
        }
    }
}

#Preview {
    AppFlow()
        .environment(NowPlayingMoviesStore(movieService: .mock))
        .environment(PopularMoviesStore(movieService: .mock))
        .environment(AnalyticsManager(providers: [MockProvider()]))
        .environment(PaymentStore(paymentManager: .mock()))
}
