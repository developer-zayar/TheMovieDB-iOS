//
//  ContentView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            MovieSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            //            FavoriteMovieView()
            //                .tabItem {
            //                    Label("Favorite", systemImage: "bookmark.fill")
            //                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden()

//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
