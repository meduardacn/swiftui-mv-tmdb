//
//  MovieCard.swift
//  SwiftU101
//
//  Created by Maria Casanova on 5/22/25.
//

import SwiftUI


struct MovieCard: View {
    let type: `Type`
    let model: Model

    var body: some View {
        Group {
            switch type {
            case .large:
                largeVariation
            case .small:
                smallVariation
            }
        }
    }

    var largeVariation: some View {
        HStack(spacing: 10) {
            Image(model.imageName)
                .resizable()
                .frame(width: 90, height: 130)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 10) {
                Text(model.title)
                    .font(.system(.body, weight: .semibold))

                model.description.map {
                    Text($0)
                        .lineLimit(3)
                        .foregroundStyle(.gray)

                }

                Button {
                    model.onTap()
                } label: {
                    HStack {
                        Image(systemName: model.isFavorited ? "star.fill" : "star")
                        Text(model.rate.description)
                    }
                    .foregroundStyle(.gray)
                }
            }
        }

    }

    var smallVariation: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(model.imageName)
                .resizable()
                .frame(width: 150, height: 230)
                .cornerRadius(10)

            Text(model.title)
                .font(.system(.body, weight: .semibold))
            Button {
                model.onTap()
            } label: {
                HStack {
                    Image(systemName: model.isFavorited ? "star.fill" : "star")
                    Text(model.rate.description)
                }
                .foregroundStyle(.gray)
            }

        }
    }
}

extension MovieCard {
    static func small(
        title: String,
        description: String,
        rate: Double,
        isFavorited: Bool,
        imageName: String,
        onTap: @escaping Action
    ) -> some View {
        MovieCard(type: .large, model: .init(
            title: title,
            description: description,
            rate: rate,
            isFavorited: isFavorited,
            imageName: imageName,
            onTap: onTap)
        )
    }

    static func large(
        title: String,
        rate: Double,
        isFavorited: Bool,
        imageName: String,
        onTap: @escaping Action
    ) -> some View {
        MovieCard(type: .small, model: .init(
            title: title,
            description: nil,
            rate: rate,
            isFavorited: isFavorited,
            imageName: imageName,
            onTap: onTap)
        )
    }
}


#Preview("Movie Card - Small") {
    List {
        MovieCard.small(
            title: "The Lion King",
            description: "Young lion prince Simba, eager to one day become king of the Pride Lands, grows up under the watchful eye of his father Mufasa; all the while his villainous uncle Scar conspires to take the throne for himself. Amid betrayal and tragedy, Simba must confront his past and find his rightful place in the Circle of Life.",
            rate: 7.1,
            isFavorited: true,
            imageName: "lion",
            onTap: {
                print("on tap")
            }
        )
        MovieCard.small(
            title: "The Lion King",
            description: "Young lion prince Simba, eager to one day become king of the Pride Lands, grows up under the watchful eye of his father Mufasa; all the while his villainous uncle Scar conspires to take the throne for himself. Amid betrayal and tragedy, Simba must confront his past and find his rightful place in the Circle of Life.",
            rate: 7.1,
            isFavorited: true,
            imageName: "lion",
            onTap: {
                print("on tap")
            }
        )
    }
}

#Preview("Movie Card - Large") {
    HStack {
        MovieCard.large(
            title: "The Lion King",
            rate: 7.1,
            isFavorited: true,
            imageName: "lion",
            onTap: {
                print("on tap")
            }
        )
        MovieCard.large(
            title: "The Lion King",
            rate: 7.1,
            isFavorited: true,
            imageName: "lion",
            onTap: {
                print("on tap")
            }
        )
    }
}

