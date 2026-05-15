//
//  Currency.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation

struct Currency: Sendable {
    let code: String
    let symbol: String
    let rate: Decimal

    static let brl = Currency(code: "BRL", symbol: "R$", rate: 1.0)
    static let usd = Currency(code: "USD", symbol: "$",  rate: 0.18)
    static let eur = Currency(code: "EUR", symbol: "€",  rate: 0.17)
}

extension Currency {
    func convert(_ amount: Decimal, to target: Currency) -> Decimal {
        let inBRL = amount / rate
        return inBRL * target.rate
    }

    func format(_ amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        return formatter.string(from: amount as NSDecimalNumber) ?? "\(symbol) \(amount)"
    }
}
