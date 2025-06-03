//
//  MoviesDTO.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

import Foundation
import SwiftUI

struct MoviesDTO: Codable {
    let dates: DatesDTO?
    let page: Int
    let results: [MovieDTO]
    let total_pages: Int
    let total_results: Int

    struct DatesDTO: Codable {
        let maximum: String
        let minimum: String
    }
    
    struct MovieDTO: Codable {
        let adult: Bool
        let backdrop_path: String
        let genre_ids: [Int]
        let id: Int
        let original_language: String
        let original_title: String
        let overview: String
        let popularity: Double
        let poster_path: String
        let release_date: Date?
        let title: String
        let video: Bool
        let vote_average: Double
        let vote_count: Int
    }
}

extension Movie {
    init(from dto: MoviesDTO.MovieDTO, imageURL: URL?, genres: [Genre]) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        self.releaseDate = dto.release_date
        self.voteAverage = dto.vote_average
        self.genres = genres
        self.posterImageURL = imageURL
    }
}
