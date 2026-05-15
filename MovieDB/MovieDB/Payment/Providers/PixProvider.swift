//
//  PixProcessor.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation

struct PixProvider: PaymentProtocol {
    var name = "Pix"
    var supportedCurrencies: [Currency] = [.brl]
    
    func process(amount: Decimal, currency: Currency) async throws -> String {
        let id = UUID()
        AppLoggers.shared.payment.log("⚡ Pix: \(currency.format(amount))")
        try await Task.sleep(for: .seconds(5))
        return id.description
    }
    
    func refund(transactionId: String, amount: Decimal, currency: Currency) async {
        AppLoggers.shared.payment.log("↩️ Pix estornando \(currency.format(amount)) | TX: \(transactionId)")
    }
}

extension PaymentProtocol where Self == PixProvider {
    static var pix: Self { .init() }
}
