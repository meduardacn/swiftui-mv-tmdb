//
//  BaseSection.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import SwiftUI

struct BaseSection<Header: View, Content: View>: View {
    let header: () -> Header?
    let content: () -> Content?

    public init(
        header: @autoclosure @escaping () -> Header? = nil,
        @ViewBuilder content:  @escaping () -> Content?
    ) {
        self.header = header
        self.content = content
    }

    public var body: some View {
        VStack {
            header()
            content()
        }
    }
}
