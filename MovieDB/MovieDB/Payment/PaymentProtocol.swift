//
//  PaymentProcessor.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation

protocol PaymentProtocol: Sendable {
    var name: String { get }
    var supportedCurrencies: [Currency] { get }

    func process(amount: Decimal, currency: Currency) async throws -> String
    func refund(transactionId: String, amount: Decimal, currency: Currency) async throws
}
