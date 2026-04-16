//
//Secrets.swift
//MovieDB
//
//CreatedbyMariaEduardaon15/04/26.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct Secret<Value:Decodable> {
    let keyPath: KeyPath<Secrets,Value>

    public var wrappedValue: Value {
        Secrets.shared[keyPath:keyPath]
    }

    public init(_ keyPath: KeyPath<Secrets,Value>) {
        self.keyPath=keyPath
    }
}

public struct Secrets: Decodable,Sendable {
    private enum CodingKeys: String, CodingKey {
        case apiKey = "TMDbAPIKey"
    }

    internal let apiKey: String

    fileprivate static let shared: Secrets = {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url)
        else {
            Log.app.critical("Failed to find Secrets.plist")
            fatalError("Failed to find Secrets.plist")
        }

        do {
            return try PropertyListDecoder().decode(Secrets.self, from: data)
        } catch let error {
            Log.app.critical("Failed to decode Secrets.plist")
            fatalError("Failed to decode Secrets.plist")
        }
    }()
}
