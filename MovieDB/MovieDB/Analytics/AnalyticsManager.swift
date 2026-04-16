//
//  AnalyticsManager.swift
//  MovieDB
//
//  Created by Maria Eduarda on 15/04/26.
//

import Foundation
import Combine

@Observable
class AnalyticsManager {
    private let provider: AnalyticsProtocol

    init(provider: AnalyticsProtocol) {
        self.provider = provider
    }

    func track(_ event: any AnalyticsEvent) {
        provider.track(event: event)
    }
}
