//
//  StripeProcessor.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation

struct StripeProvider: PaymentProtocol {
    var name = "Stripe"
    var supportedCurrencies: [Currency] = [.brl, .usd, .eur]

    func process(amount: Decimal, currency: Currency) async throws -> String {
        let id = "stripe_\(UUID().uuidString.prefix(8))"
        AppLoggers.shared.payment.log("💳 Stripe: \(currency.format(amount))")
        try await Task.sleep(for: .seconds(5))
        return id
    }

    func refund(transactionId: String, amount: Decimal, currency: Currency) async {
        AppLoggers.shared.payment.log("↩️ Stripe estornando \(currency.format(amount)) | TX: \(transactionId)")
    }
}

extension PaymentProtocol where Self == StripeProvider {
    static var stripe: Self { .init() }
}
