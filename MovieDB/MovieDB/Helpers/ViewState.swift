//
//  ViewState.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import Foundation

public enum ViewState<Value> {
    public typealias Result = Swift.Result<Value, any Error>

    case loading
    case complete(Result)

    public static func complete(_ value: Value) -> Self {
        .complete(.success(value))
    }

    public static func complete(_ error: Error) -> Self {
        .complete(.failure(error))
    }

    public var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    public var hasCompleted: Bool {
        switch self {
        case .complete(.success):
            return true
        default:
            return false
        }
    }

    public var hasFailed: Bool {
        switch self {
        case .complete(.failure):
            return true
        default:
            return false
        }
    }
}

extension ViewState where Value == Void {
    public static var complete: Self {
        .complete(.success(()))
    }
}
