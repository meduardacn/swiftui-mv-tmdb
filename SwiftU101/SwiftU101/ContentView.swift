//
//  ContentView.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .frame(width: 50, height: 50)
            Text("SwiftUI")
                .font(.largeTitle)
        }
        .foregroundStyle(.blue)
        .padding()
    }
}

#Preview {
    ContentView()
}
