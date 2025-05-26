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
        VStack {
            Text("Hello, SwiftUI101!")
                .font(.largeTitle)
            Image(systemName: "swift")
                .resizable()
                .frame(width: 100, height: 100)
        }
        .foregroundStyle(Color.appBlue)
        .padding()
    }
}

#Preview {
    ContentView()
}
