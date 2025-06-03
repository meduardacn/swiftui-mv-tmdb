//
//  MovieCard+Model.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//
import SwiftUI

extension MovieCard {
    public typealias Action = () -> Void

    struct Model {
        let title: String
        let description: String?
        let rate: Double
        let isFavorited: Bool
        let imageURL: URL?
        let onTap: Action
    }

    enum `Type` {
        case large
        case small
    }
}
