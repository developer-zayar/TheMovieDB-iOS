//
//  AutoScrollingTabView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import Combine
import SwiftUI

struct AutoImageSliderView: View {
    let movies: [Movie]
    let timeInterval: Int

    @State private var currentIndex: Int = 0
    @State private var selectedMovie: Movie?
    @State private var isShowingDetails: Bool = false

//    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    private var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: TimeInterval(timeInterval), on: .main, in: .common).autoconnect()
    }

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0 ..< movies.count, id: \.self) { index in
                VStack {
                    AsyncImage(url: movies[index].backdropURL) { image in
                        image.resizable().scaledToFill()
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
                    .frame(height: 200)
                    .cornerRadius(12)

                    HStack {
                        Text(movies[index].title)
                            .font(.subheadline)
                            .lineLimit(2)

                        Spacer()

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.subheadline)

                            Text("\(movies[index].voteAverage, specifier: "%.1f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                .tag(index)
                .onTapGesture {
                    selectedMovie = movies[index]
                    isShowingDetails = true
                }
            }
        }
        .frame(height: 240)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % movies.count
            }
        }
        .navigationDestination(isPresented: $isShowingDetails) {
            if let selectedMovie {
                MovieDetailsView(movieId: selectedMovie.id)
            }
        }
    }
}
