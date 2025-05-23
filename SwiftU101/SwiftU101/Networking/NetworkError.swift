//
//  NetworkError.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/23/25.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidResponse(URLResponse)
    case invalidError(URLResponse, Int)
    case endpointError
    case unauthorized
    case invalidUrl
}
