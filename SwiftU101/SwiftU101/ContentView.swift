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

    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .frame(width: 50, height: 50)
            Text("SwiftUI")
                .font(.largeTitle)
        }
        .task {
            do {
                let image: UIImage = try await network.image(for: .fetchImage(filePath: "wwemzKWzjKYJFfCeiB57q3r4Bcm.png"))
                let some = Image(uiImage: image)
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
