//
//  MockProvider.swift
//  MovieDB
//
//  Created by Maria Eduarda on 16/04/26.
//

struct MockProvider: AnalyticsProtocol {
    func track(event: any AnalyticsEvent) {
        guard let properties = event.properties else { return }
        properties.forEach { print("\($0.key): \($0.value, default: "")") }
    }
}
