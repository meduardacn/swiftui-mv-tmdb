//
//  MockMovie.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//
import Foundation
import SwiftUI

extension Movie {
    static var mock: Self {
        .init(
            id: 1,
            title: "The Lion King",
            overview: "Young lion prince Simba, eager to one day become king of the Pride Lands, grows up under the watchful eye of his father Mufasa; all the while his villainous uncle Scar conspires to take the throne for himself. Amid betrayal and tragedy, Simba must confront his past and find his rightful place in the Circle of Life.",
            releaseDate: MockDate.mock("1994-06-15"),
            voteAverage: 8.3,
            genres: [.family, .animation, .drama],
            posterImage: Image("lion")
        )
    }
}
