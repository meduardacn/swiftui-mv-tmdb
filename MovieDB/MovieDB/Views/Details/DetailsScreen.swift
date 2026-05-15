//
//  DetailsScreen.swift
//  SwiftU101
//
//  Created by Maria Eduarda on 25/05/25.
//

import SwiftUI

struct DetailsScreen: View {

    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                MovieDetailHeader(movie: movie)
                MovieDetailOverview(text: movie.overview)
                MovieRentSection(movie: movie)
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct MovieDetailHeader: View {
    let movie: Movie

    private var genresText: String {
        movie.genres.map(\.name).joined(separator: ", ")
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: movie.posterImageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.15)
            }
            .frame(width: 128, height: 194)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)

                if !genresText.isEmpty {
                    Text(genresText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 4) {
                    Image(systemName: "star")
                    Text(movie.voteAverage.formatted(.number.precision(.fractionLength(1))))
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct MovieDetailOverview: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview")
                .font(.headline)
            Text(text)
                .font(.body)
        }
    }
}

private struct MovieRentSection: View {
    @Environment(PaymentStore.self) private var paymentStore
    let movie: Movie
    @State private var selectedMethod: PaymentMethod?


    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rent")
                .font(.headline)

            VStack(spacing: 0) {
                ForEach(paymentStore.availableMethods, id: \.self) { method in
                    PaymentMethodRow(method: method, isSelected: selectedMethod == method)
                        .contentShape(Rectangle())
                        .onTapGesture { selectedMethod = method }

                    if method != paymentStore.availableMethods.last {
                        Divider().padding(.leading, 52)
                    }
                }
            }
            .background(.gray.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button("Rent Now") {
                Task {
                    if let selectedMethod {
                        await paymentStore.select(selectedMethod)
                        await paymentStore.checkout(amount: movie.price)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .disabled(selectedMethod == nil)

            switch paymentStore.state {
            case .loading:
                loadingView
            case .complete(.success(let value)) where value != nil:
                successView
            case .complete(.failure):
                errorView
            default:
                EmptyView()
            }
        }
        .onDisappear {
            paymentStore.reset()
        }
    }

    var loadingView: some View {
        HStack(spacing: 10) {
            ProgressView()
                .tint(.white)
            Text("Processing payment…")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.indigo)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var errorView: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
            VStack(alignment: .leading, spacing: 2) {
                Text("Something went wrong")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var successView: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
            Text("Movie rented successfully!")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct PaymentMethodRow: View {
    let method: PaymentMethod
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: method.icon)
                .frame(width: 28)
                .foregroundStyle(isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(.secondary))
            Text(method.title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundStyle(.tint)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .padding()
        .background(isSelected ? Color.accentColor.opacity(0.08) : Color.clear)
        .animation(.snappy, value: isSelected)
    }
}

#Preview {
    NavigationStack {
        DetailsScreen(movie: .mock)
    }
    .environment(PaymentStore(paymentManager: .mock()))
}
