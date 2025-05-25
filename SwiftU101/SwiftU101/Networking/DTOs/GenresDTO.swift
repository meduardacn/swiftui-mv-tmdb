//
//  GenresDTO.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

import Foundation

struct GenresDTO: Decodable, Encodable {
    let genres: [ResultsDTO]

    struct ResultsDTO: Decodable, Encodable {
        let id: Int
        let name: String
    }
}

extension Genre {
    init (from dto: GenresDTO.ResultsDTO) {
        id = dto.id
        name = dto.name
    }
}
