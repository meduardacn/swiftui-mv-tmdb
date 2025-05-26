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
        switch type {
        case .large:
            largeVariation
        case .small:
            smallVariation
        }
    }

    var smallVariation: some View {
        HStack(spacing: 10) {
            model.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(idealWidth: 80, idealHeight: 120)

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

    var largeVariation: some View {
        VStack(alignment: .leading, spacing: 8) {
            model.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)

            Text(model.title)
                .lineLimit(1)
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
        image: Image,
        onTap: @escaping Action
    ) -> some View {
        MovieCard(type: .small, model: .init(
            title: title,
            description: description,
            rate: rate,
            isFavorited: isFavorited,
            image: image,
            onTap: onTap)
        )
    }

    static func large(
        title: String,
        rate: Double,
        isFavorited: Bool,
        image: Image,
        onTap: @escaping Action
    ) -> some View {
        MovieCard(type: .large, model: .init(
            title: title,
            description: nil,
            rate: rate,
            isFavorited: isFavorited,
            image: image,
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
            image: Image("lion"),
            onTap: {
                print("on tap")
            }
        )
        MovieCard.small(
            title: "The Lion King",
            description: "Young lion prince Simba, eager to one day become king of the Pride Lands, grows up under the watchful eye of his father Mufasa; all the while his villainous uncle Scar conspires to take the throne for himself. Amid betrayal and tragedy, Simba must confront his past and find his rightful place in the Circle of Life.",
            rate: 7.1,
            isFavorited: true,
            image: Image("lion"),
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
            image: Image("lion"),
            onTap: {
                print("on tap")
            }
        )
        MovieCard.large(
            title: "The Lion King",
            rate: 7.1,
            isFavorited: true,
            image: Image("lion"),
            onTap: {
                print("on tap")
            }
        )
    }
}

