//
//  ExtractedView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 26/01/2025.
//

import SwiftUI

struct CastsView: View {
    let casts: [Cast]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Casts")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(casts) { cast in
                        VStack {
                            AsyncImage(url: cast.profileURL) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 80, height: 100)
                                    .overlay {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundStyle(.gray)
                                            .frame(width: 40, height: 40)
                                    }
                            }

                            Text(cast.name)
                                .font(.caption)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 80, height: 160, alignment: .top)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
