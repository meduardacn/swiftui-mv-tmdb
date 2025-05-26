//
//  ContentView.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @EnvironmentObject private var store: Store

    var body: some View {
        NavigationStack {
            
            Section(header: Text("Movies")) {
                List {
                    ForEach(store.popularMovies ?? []) { movie in
                        Text(movie.title)
                    }
                }
            }
        }
        .navigationTitle("The Movie DB")
    }
}

#Preview {
    ContentView()
        .environmentObject(Store(moviesService: .mock))
}
