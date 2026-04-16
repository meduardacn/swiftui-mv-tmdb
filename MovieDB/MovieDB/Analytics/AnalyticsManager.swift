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
    func track(_ event: any AnalyticsEvent) {

        event.track()
    }
}
