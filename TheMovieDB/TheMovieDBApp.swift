//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
    private let appStorageManager = AppStorageManager()

    var body: some Scene {
        let isFirstLaunch: Bool = appStorageManager.getObject(forKey: UserDefaultKeys.isFirstLaunch) == nil
        WindowGroup {
            if isFirstLaunch {
                OnboardingView()
            } else {
                ContentView()
            }
//            if authViewModel.isLoggedIn {
//                ContentView()
//            } else {
//                LoginView()
//            }
        }
    }
}
