//
//  Endpoint+Image.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/25/25.
//

extension Endpoint {
    static func fetchImage(filePath: String) -> Endpoint {
        return Endpoint(
            url: .imageUrl(path: filePath),
            headers: .empty,
            method: .get()
        )
    }
}
