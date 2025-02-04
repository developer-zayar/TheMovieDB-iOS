//
//  OnboardingView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 03/02/2025.
//

import SwiftUI

struct OnboardingView: View {
    private let appStorageManager = AppStorageManager()

    @State private var currentIndex = 0
    @State private var navigateToMain = false

    let onboardingData = [
        ("onboarding1", "Welcome to TheMovieDB", "Discover the latest movies and TV shows."),
        ("onboarding2", "Exclusive Content", "Watch trailers and behind-the-scenes footage."),
        ("onboarding3", "Track Your Favorites", "Save your favorite movies to watch later and build your watchlist."),
        ("onboarding4", "Stay Updated", "Get notified about the latest releases and trending movies."),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geo in
                    ScrollView {
                        TabView(selection: $currentIndex) {
                            ForEach(0 ..< onboardingData.count, id: \.self) { index in
                                OnboardingViewItem(
                                    imageName: onboardingData[index].0,
                                    title: onboardingData[index].1,
                                    subtitle: onboardingData[index].2
                                )
                                .tag(index)
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                    }
                    .scrollDisabled(true)
                }
                .ignoresSafeArea()

//                TabView(selection: $currentIndex) {
//                    ForEach(0 ..< onboardingData.count, id: \.self) { index in
//                        OnboardingViewItem(
//                            imageName: onboardingData[index].0,
//                            title: onboardingData[index].1,
//                            subtitle: onboardingData[index].2
//                        )
//                        .tag(index)
//                    }
//                }
//                .tabViewStyle(.page(indexDisplayMode: .always))
//                .ignoresSafeArea(edges: [.top, .bottom])

                VStack {
                    Spacer()
                    Button(action: {
                        if currentIndex < onboardingData.count - 1 {
                            currentIndex += 1
                        } else {
                            appStorageManager.saveObject(true, forKey: UserDefaultKeys.isFirstLaunch)
                            print("Onboarding Finished")
                            navigateToMain = true
                        }
                    }) {
                        Text(currentIndex == onboardingData.count - 1 ? "Get Started" : "Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.tmdbSecondary)
                            .clipShape(Capsule())
                            .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 24)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $navigateToMain) {
                ContentView()
            }
        }
    }
}

#Preview {
    OnboardingView()
}

struct OnboardingViewItem: View {
    let imageName: String
    let title: String
    let subtitle: String
    let logoImageName: String? = nil

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Spacer()

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.tmdbPrimary.opacity(1),
                        Color.tmdbPrimary.opacity(0.8),
                        Color.clear,
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 400)
                .overlay(
                    VStack(spacing: 12) {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48)

                        Text(subtitle)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 48)
                    }
                    .padding(.bottom)
                )
            }
        }
        .ignoresSafeArea(edges: .vertical)
    }
}
