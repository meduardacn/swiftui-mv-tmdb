//
//  PayPalProcessor.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation

struct PayPalProvider: PaymentProtocol {
    var name = "PayPal"
    var supportedCurrencies: [Currency] = [.brl, .usd, .eur]

    func process(amount: Decimal, currency: Currency) async throws -> String {
        let id = Int.random(in: 100_000...999_999)
        AppLoggers.shared.payment.log("🅿️ PayPal: \(currency.format(amount))")
        try await Task.sleep(for: .seconds(5))
        return id.description
    }

    func refund(transactionId: String, amount: Decimal, currency: Currency) async throws {
        AppLoggers.shared.payment.log("↩️ PayPal estornando \(currency.format(amount)) | TX: \(transactionId)")
    }
}

extension PaymentProtocol where Self == PayPalProvider {
    static var paypal: Self { .init() }
}
