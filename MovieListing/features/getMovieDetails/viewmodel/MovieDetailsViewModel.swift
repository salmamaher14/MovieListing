//
//  MovieDetailsViewModel.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
protocol MovieDetailsViewmodelProtocol{
    func getSelectedMovie() -> Movie
}

class MovieDetailsViewModel: MovieDetailsViewmodelProtocol{
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getSelectedMovie() -> Movie {
        return movie
    }
}
