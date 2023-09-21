//
//  DatabaseManager.swift
//  testmovies
//
//  Created by Stanislav Seryogin on 20.09.2023.
//

import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ModelName") // Replace "ModelName" with the name of your CoreData model
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("CoreData Error: \(error)")
            }
        }
    }

    // Save movies to the CoreData
    func saveMovies(_ movies: [Movie]) {
        let context = container.viewContext

        for movie in movies {
            let entity = MovieEntity(context: context)
            entity.id = Int32(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.vote_average = movie.vote_average
            entity.release_date = movie.release_date
            entity.poster_path = movie.poster_path
            entity.trailer_path = movie.trailer_path
            entity.country = movie.country
            entity.popularity = movie.popularity ?? 0.0

            if let genreIDs = movie.genre_ids {
                entity.genre_ids = NSOrderedSet(array: genreIDs)
            }
        }

        do {
            try context.save()
        } catch {
            print("Failed to save movies: \(error)")
        }
    }


    // Fetch movies from CoreData and convert to `Movie` structure
    func fetchMovies() -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            let results = try container.viewContext.fetch(request)
            return results.map { Movie(entity: $0) }
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }

    // Search for movies by title in CoreData
    func searchMovies(by title: String) -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", title)
        do {
            let results = try container.viewContext.fetch(request)
            return results.map { Movie(entity: $0) }
        } catch {
            print("Failed to search movies: \(error)")
            return []
        }
    }
}


