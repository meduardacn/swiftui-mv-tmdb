//
//  NowPlayingDTO.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

struct NowPlayingDTO: Decodable, Encodable {
    let dates: DatesDTO
    let page: Int
    let results: [MovieDTO]
    let total_pages: Int
    let total_results: Int

    struct DatesDTO: Decodable, Encodable{
        let maximum: String
        let minimum: String
    }
}
