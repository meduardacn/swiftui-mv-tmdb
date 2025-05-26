//
//  DateFormatter.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import Foundation

extension DateFormatter {
    static let movieDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
