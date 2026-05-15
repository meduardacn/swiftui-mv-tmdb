//
//  PaymentStore.swift
//  MovieDB
//
//  Created by Maria Eduarda on 11/05/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class PaymentStore {
    private let paymentManager: PaymentManager
    var availableMethods: [PaymentMethod] { paymentManager.availableMethods }
    var lastTransactionId: String?
    private(set) var state: ViewState<String?> = .complete(nil)

    init(paymentManager: PaymentManager = .make()) {
        self.paymentManager = paymentManager
    }

    func select(_ method: PaymentMethod) async {
        await paymentManager.select(method)
    }

    func checkout(amount: Decimal, currency: Currency = .brl) async {
        do {
            state = .loading
            let transactionId = try await paymentManager.process(amount: amount, currency: currency)
            lastTransactionId = transactionId
            state = .complete(transactionId)
        } catch {
            state = .complete(.failure(error))
        }
    }

    func refund(currency: Currency = .brl) async {
        guard let txId = lastTransactionId else { return }
        do {
            state = .loading
            try await paymentManager.refund(transactionId: txId, amount: 0, currency: currency)
            lastTransactionId = nil
            state = .complete(nil)
        } catch {
            state = .complete(.failure(error))
        }
    }

    func reset() {
        state = .complete(nil)
    }
}
