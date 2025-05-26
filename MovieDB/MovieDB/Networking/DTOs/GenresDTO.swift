//
//  GenresDTO.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

import Foundation

struct GenresDTO: Codable {
    let genres: [ResultsDTO]

    struct ResultsDTO: Codable {
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
