//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import SwiftData
import SwiftUI

@main
struct TheMovieDBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Movie.self])
    }
}
