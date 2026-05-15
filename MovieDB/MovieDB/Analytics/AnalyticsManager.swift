//
//  AnalyticsManager.swift
//  MovieDB
//
//  Created by Maria Eduarda on 15/04/26.
//

import Foundation

@Observable
final class AnalyticsManager {
    private let providers: [AnalyticsProtocol]

    init(providers: [AnalyticsProtocol]) {
        self.providers = providers
    }

    func track(_ event: any AnalyticsEvent) {
        providers.forEach { $0.track(event: event) }
    }
}
