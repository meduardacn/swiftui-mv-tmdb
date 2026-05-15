import OSLog

public enum Log {
    private static let systemIdentifier = Bundle.main.bundleIdentifier ?? "poatek.SwiftU101"
    public static let app       = Logger(subsystem: systemIdentifier, category: "App Lifecycle")
    public static let auth      = Logger(subsystem: systemIdentifier, category: "Authentication")
    public static let ui        = Logger(subsystem: systemIdentifier, category: "User Interface")
    public static let network   = Logger(subsystem: systemIdentifier, category: "Networking")
    public static let analytics = Logger(subsystem: systemIdentifier, category: "Analytics")
    public static let payment   = Logger(subsystem: systemIdentifier, category: "Payment")
}

protocol Loggable: Sendable {
    func log(_ message: String)
}

struct OSLoggable: Loggable {
    enum Category {
        case app, auth, ui, network, analytics, payment

        var logger: Logger {
            switch self {
            case .app:       return Log.app
            case .auth:      return Log.auth
            case .ui:        return Log.ui
            case .network:   return Log.network
            case .analytics: return Log.analytics
            case .payment:   return Log.payment
            }
        }
    }

    private let category: Category

    init(category: Category) {
        self.category = category
    }

    func log(_ message: String) {
        category.logger.log("\(message, privacy: .public)")
    }
}

struct TimestampLoggable: Loggable {
    private let inner: any Loggable
    init(_ inner: any Loggable) { self.inner = inner }

    func log(_ message: String) {
        inner.log("[\(Date().formatted(.dateTime))] \(message)")
    }
}

struct SeverityLoggable: Loggable {
    enum Level: String {
        case info    = "INFO"
        case warning = "WARNING"
        case error   = "ERROR"
    }

    private let inner: any Loggable
    private let level: Level

    init(_ inner: any Loggable, level: Level) {
        self.inner = inner
        self.level = level
    }

    func log(_ message: String) {
        inner.log("[\(level.rawValue)] \(message)")
    }
}

struct FilterLoggable: Loggable {
    private let inner: any Loggable
    private let keyword: String

    init(_ inner: any Loggable, keyword: String) {
        self.inner = inner
        self.keyword = keyword
    }

    func log(_ message: String) {
        guard message.contains(keyword) else { return }
        inner.log(message)
    }
}
