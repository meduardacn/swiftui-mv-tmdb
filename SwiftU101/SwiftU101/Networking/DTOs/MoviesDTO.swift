//
//  MoviesDTO.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

struct MoviesDTO: Decodable, Encodable {
    let dates: DatesDTO?
    let page: Int
    let results: [MovieDTO]
    let total_pages: Int
    let total_results: Int

    struct DatesDTO: Decodable, Encodable{
        let maximum: String
        let minimum: String
    }
    
    struct MovieDTO: Decodable, Encodable {
        let adult: Bool
        let backdrop_path: String
        let genre_ids: [Int]
        let id: Int
        let original_language: String
        let original_title: String
        let overview: String
        let popularity: Double
        let poster_path: String
        let release_date: String
        let title: String
        let video: Bool
        let vote_average: Double
        let vote_count: Int
    }
}
