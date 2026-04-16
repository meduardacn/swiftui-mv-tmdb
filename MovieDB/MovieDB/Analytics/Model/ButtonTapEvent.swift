//
//  ButtonTapEvent.swift
//  MovieDB
//
//  Created by Maria Eduarda on 15/04/26.
//

struct ButtonTapEvent: AnalyticsEvent {
    var name: AnalyticsEventName = "ButtonTap"
    let buttonText: String
    var properties: AnalyticsEventProperties? {
        [
            "EventName": name,
            "buttonText": buttonText
        ]
    }

    func track() {
        guard let properties else { return }
        properties.forEach { print("\($0.key): \($0.value, default: "")") }
    }
}

extension AnalyticsEvent where Self == ButtonTapEvent {
    static func buttonTap(withText buttonText: String) -> Self {
        .init(buttonText: buttonText)
    }
}
