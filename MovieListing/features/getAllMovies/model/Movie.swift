//
//  Movie.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation


struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    let overview: String
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
    }
}
