//
//  MockDate.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//
import Foundation


public enum MockDate{
    public static func mock(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: date) else {
            Log.app.debug("Failed to mock date")
            return Date(timeIntervalSince1970: 0)
        }

        return date
    }
}
