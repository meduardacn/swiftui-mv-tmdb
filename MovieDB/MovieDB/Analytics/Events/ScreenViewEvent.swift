//
//  ScreenViewEvent.swift
//  MovieDB
//
//  Created by Maria Eduarda on 15/04/26.
//

struct ScreenViewEvent: AnalyticsEvent {
    var name: AnalyticsEventName = "ScreenView"
    let screenName: String
    var properties: AnalyticsEventProperties? {
        [
            "EventName": name,
            "ScreenName": screenName
        ]
    }
}

extension AnalyticsEvent where Self == ScreenViewEvent {
    static func screenView(with screenName: String) -> Self {
        .init(screenName: screenName)
    }
}
