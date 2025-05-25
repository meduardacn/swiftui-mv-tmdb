//
//  Movie.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import Foundation
import SwiftUI

public struct Movie: Sendable {
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: Date
    public let voteAverage: Double
    public let genres: [Genre] //TODO: review this
    public let posterImage: Image //TODO: review this
}
