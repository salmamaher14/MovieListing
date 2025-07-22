//
//  MovieCoreData.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
import CoreData
import UIKit



class MovieCoreData {

    static let shared = MovieCoreData()
    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    func insert(movie: Movie) {
        let newMovie = MovieData(context: context)
        newMovie.title = movie.title
        newMovie.original_language = movie.originalLanguage
        newMovie.overview = movie.overview
        newMovie.poster_path = movie.posterPath
        newMovie.vote_average = movie.voteAverage

        saveContext()
    }

    func fetchAll() -> [MovieData] {
        let request: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }

    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MovieData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print(" Error deleting all movies: \(error)")
        }
    }
    
    func saveMovies(_ movies: [Movie]) {
        let existingMovies = fetchAll()
        let existingTitles = Set(existingMovies.map { $0.title ?? "" })

        for movie in movies {
            guard !existingTitles.contains(movie.title) else { continue }

            let newMovie = MovieData(context: context)
            newMovie.title = movie.title
            newMovie.original_language = movie.originalLanguage
            newMovie.overview = movie.overview
            newMovie.poster_path = movie.posterPath
            newMovie.vote_average = movie.voteAverage
            newMovie.isFav = false   //
        }

        saveContext()
    }


    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(" Failed to save context: \(error)")
        }
    }
}
