//
//  ContentView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import SwiftUI

struct ContentView: View {
    private let appStorageManager = AppStorageManager()

    @State private var isFirstLaunch: Bool = false

    init() {
        let isLaunched = appStorageManager.getObject(forKey: UserDefaultKeys.isFirstLaunch) != nil
        _isFirstLaunch = State(initialValue: !isLaunched)
    }

    var body: some View {
        if isFirstLaunch {
            OnboardingView(isFirstLaunch: $isFirstLaunch)
        } else {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                MovieSearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
