//
//  EmptyMoviesView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 06/02/2025.
//

import SwiftUI

struct EmptyMoviesView: View {
    let imageName: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.6))

            Text(title)
                .font(.headline)
                .foregroundColor(.gray)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyMoviesView(imageName: "heart.slash.fill", title: "No Favorite Movies", subtitle: "Add movies to your favorites to see them here.")
}
