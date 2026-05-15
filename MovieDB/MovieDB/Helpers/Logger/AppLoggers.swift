//
//  AppLoggers.swift
//  MovieDB
//
//  Created by Maria Eduarda on 14/05/26.
//

import OSLog

final class AppLoggers: Sendable {
    static let shared = AppLoggers()

    let network: Loggable
    let auth: Loggable
    let payment: Loggable
    let ui: Loggable
    let analytics: Loggable

    private init() {
        let level: SeverityLoggable.Level = {
            #if DEBUG
            return .info
            #else
            return .error
            #endif
        }()

        network = FilterLoggable(
            TimestampLoggable(
                SeverityLoggable(
                    OSLoggable(category: .network),
                    level: level
                )
            ),
            keyword: "Request"
        )

        auth = TimestampLoggable(
            SeverityLoggable(
                OSLoggable(category: .auth),
                level: level
            )
        )

        payment = TimestampLoggable(
            SeverityLoggable(
                OSLoggable(category: .payment),
                level: level
            )
        )

        ui = TimestampLoggable(
            OSLoggable(category: .ui)
        )

        analytics = TimestampLoggable(
            OSLoggable(category: .analytics)
        )
    }
}
