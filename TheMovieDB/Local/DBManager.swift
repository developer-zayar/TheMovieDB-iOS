//
//  DBManager.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 05/02/2025.
//

import Foundation
import SwiftData

class DBManager {
    static let shared = DBManager()

    let container: ModelContainer
//    let movieDao: MovieDao

    private init() {
        do {
            let schemas = Schema([Movie.self])
//            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schemas)
        } catch {
            print("Failed to initialize the database: \(error.localizedDescription)")
            fatalError("Failed to initialize SwiftData container \(error.localizedDescription)")
        }

//        movieDao = MovieDao(context: container.mainContext)
    }
}
