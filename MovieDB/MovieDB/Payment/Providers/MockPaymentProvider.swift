//
//  MockPaymentProcessor.swift
//  MovieDB
//

import Foundation

struct MockPaymentProvider: PaymentProtocol {
    typealias ProcessProvider = @Sendable (Decimal, Currency) async throws -> String
    typealias RefundProvider  = @Sendable (String, Decimal, Currency) async throws -> Void

    var name: String
    var supportedCurrencies: [Currency]
    let providerProcess: ProcessProvider
    let providerRefund: RefundProvider

    init(
        name: String = "Mock",
        supportedCurrencies: [Currency] = [.brl, .usd, .eur],
        providerProcess: @escaping ProcessProvider = { _, _ in "mock_tx_\(UUID().uuidString.prefix(8))" },
        providerRefund: @escaping RefundProvider  = { _, _, _ in }
    ) {
        self.name = name
        self.supportedCurrencies = supportedCurrencies
        self.providerProcess = providerProcess
        self.providerRefund = providerRefund
    }

    func process(amount: Decimal, currency: Currency) async throws -> String {
        try await providerProcess(amount, currency)
    }

    func refund(transactionId: String, amount: Decimal, currency: Currency) async throws {
        try await providerRefund(transactionId, amount, currency)
    }
}

extension PaymentProtocol where Self == MockPaymentProvider {
    static var mock: Self { .init() }
}
