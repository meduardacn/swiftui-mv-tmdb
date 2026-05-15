//
//  FirabaseProvider.swift
//  MovieDB
//
//  Created by Maria Eduarda on 16/04/26.
//

import Foundation

struct FirebaseProvider: AnalyticsProtocol {
    func track(event: any AnalyticsEvent) {
        guard let properties = event.properties else { return }
        let body = properties.map { "\($0.key): \($0.value ?? "nil")" }.joined(separator: "\n")
        AppLoggers.shared.analytics.log("FIREBASE\n\(body)")
    }
}
