//
//  AnalyticsEvent.swift
//  MovieDB
//
//  Created by Maria Eduarda on 15/04/26.
//

import Foundation

public typealias AnalyticsEventName = String
public typealias AnalyticsEventProperties = [String: Any?]

protocol AnalyticsEvent {
    var name: AnalyticsEventName { get }
    var properties: AnalyticsEventProperties? { get }
    func track()
}
