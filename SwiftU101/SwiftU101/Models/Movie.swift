//
//  Movie.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

import Foundation
import SwiftUI

struct Movie: Sendable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
    let voteAverage: Double
    let genres: [String] //TODO: review this
    let posterImage: Image //TODO: review this
}
