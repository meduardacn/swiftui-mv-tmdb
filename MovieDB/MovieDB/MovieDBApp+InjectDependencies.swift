//
//  MovieDBApp+InjectDependencies.swift
//  MovieDB
//
//  Created by Maria Eduarda on 14/05/26.
//

import Foundation
import SwiftUI

extension View {
    func injectDependencies() -> some View {
        modifier(MovieDBApp.DependenciesInjectionModifier())
    }
}

extension MovieDBApp {
    struct DependenciesInjectionModifier: ViewModifier {
        @State private var analyticsManager = AnalyticsManager(providers: [FirebaseProvider()])
        @State private var nowPlayingMoviesStore = NowPlayingMoviesStore()
        @State private var paymentStore = PaymentStore()
        @State private var popularMoviesStore = PopularMoviesStore()

        func body(content: Content) -> some View {
            content
                .environment(analyticsManager)
                .environment(nowPlayingMoviesStore)
                .environment(paymentStore)
                .environment(popularMoviesStore)
        }
    }
}
