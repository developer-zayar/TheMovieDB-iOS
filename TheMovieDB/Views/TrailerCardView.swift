//
//  TrailerCardView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

import SwiftUI

struct TrailerCardView: View {
    let video: MovieVideo

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: AppUtils.getYoutubeThumbnail(key: video.key)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 100)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.gray)
                            .frame(height: 60)
                    }
            }
            .cornerRadius(8)

            Text(video.name)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 160)
        }
        .frame(width: 160, height: 160, alignment: .top)
    }
}
