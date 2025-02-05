//
//  MovieDao.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 05/02/2025.
//

import Foundation
import SwiftData

class MovieDao {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func insert(_ movie: Movie) {
        context.insert(movie)
        saveContext()
    }

    func getAll() -> [Movie] {
        do {
            let descriptor = FetchDescriptor<Movie>()
            return try context.fetch(descriptor)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return []
        }
    }

    func delete(_ movie: Movie) {
        context.delete(movie)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}
