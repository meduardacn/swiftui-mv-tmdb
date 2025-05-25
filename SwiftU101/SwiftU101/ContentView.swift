//
//  ContentView.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let network = NetworkClient()
    @State private var loadedImage: UIImage?

    var body: some View {
        VStack {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            } else {
                ProgressView()
                    .frame(height: 200)
            }
        }
        .task {
            do {
                let image: UIImage = try await network.image(for: .fetchImage(filePath: "wwemzKWzjKYJFfCeiB57q3r4Bcm.png"))
                loadedImage = image
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
