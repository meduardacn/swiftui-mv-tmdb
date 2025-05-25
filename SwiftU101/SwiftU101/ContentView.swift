//
//  ContentView.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let service = MovieDBMoviesService()
    @State private var movies: [Movie]?

    var body: some View {
        VStack {
            if let movies = movies, !movies.isEmpty {
                List(movies) { movie in
                    Text(movie.title)
                    movie.posterImage
                        .resizable()
                        .frame(height: 200)

                }
            } else {
                ProgressView()
                    .frame(height: 200)
            }
        }
        .task {
            do {
                try await movies = service.fetchPopularMovies(page: 1)
            } catch {
                print(error)
            }
        }
        .foregroundStyle(.blue)
        .padding()
    }
}

#Preview {
    ContentView()
}
