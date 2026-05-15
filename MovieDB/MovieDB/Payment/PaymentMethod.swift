//
//  PaymentMethod.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//
import Foundation

enum PaymentMethod: CaseIterable, Hashable {
    case creditCard, pix, payPal, mock

    var title: String {
        switch self {
        case .creditCard: "Credit Card"
        case .pix:        "Pix"
        case .payPal:     "PayPal"
        case .mock:       "Mock"
        }
    }

    var icon: String {
        switch self {
        case .creditCard: "creditcard"
        case .pix:        "qrcode"
        case .payPal:     "p.circle"
        case .mock:       "p.circle"
        }
    }

    func make() -> any PaymentProtocol {
        switch self {
        case .pix:    return .pix
        case .creditCard: return .stripe
        case .payPal: return .paypal
        case .mock:   return .mock
        }
    }
}
