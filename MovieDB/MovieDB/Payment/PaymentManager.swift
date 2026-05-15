//
//  ManagerPaymentProcessor.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation
import Observation

actor PaymentManager {
    private let processors: [PaymentMethod: any PaymentProtocol]
    nonisolated let availableMethods: [PaymentMethod]
    private(set) var activeMethod: PaymentMethod = .pix

    var name: String { active.name }
    var supportedCurrencies: [Currency] { active.supportedCurrencies }

    private var active: any PaymentProtocol {
        guard let p = processors[activeMethod] else {
            preconditionFailure("No processor registered for \(activeMethod)")
        }
        return p
    }

    init(processors: [PaymentMethod: any PaymentProtocol], orderedMethods: [PaymentMethod]) {
        self.processors = processors
        self.availableMethods = orderedMethods
    }

    func select(_ method: PaymentMethod) {
        activeMethod = method
    }

    func process(amount: Decimal, currency: Currency) async throws -> String {
        try await active.process(amount: amount, currency: currency)
    }

    func refund(transactionId: String, amount: Decimal, currency: Currency) async throws {
        try await active.refund(transactionId: transactionId, amount: amount, currency: currency)
    }
}

extension PaymentManager {
    static func make() -> PaymentManager {
        let methods: [PaymentMethod] = [.creditCard, .payPal, .pix]
        let processors = Dictionary(uniqueKeysWithValues: methods.map { ($0, $0.make()) })
        return .init(processors: processors, orderedMethods: methods)
    }

    static func mock() -> PaymentManager {
        let methods: [PaymentMethod] = [.mock]
        let processors = Dictionary(uniqueKeysWithValues: methods.map { ($0, $0.make()) })
        return .init(processors: processors, orderedMethods: methods)
    }
}
