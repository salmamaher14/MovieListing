//
//  TopMoviesViewModel.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
import Combine


protocol TopMoviesViewModelProtocol {
    var moviesPublisher: Published<[Movie]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    var movies: [Movie] { get }
    func fetchMovies()
}


class TopMoviesViewModel: TopMoviesViewModelProtocol {
    private let movieService: MovieNetworkService
    
    @Published private(set) var movies: [Movie] = []
    @Published var isLoading: Bool = false
    
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var moviesPublisher: Published<[Movie]>.Publisher { $movies }

    init(movieService: MovieNetworkService) {
        self.movieService = movieService
    }

    func fetchMovies() {
        isLoading = true
        movieService.fetchTopMovies()
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            },
                  receiveValue: { [weak self] movies in
                print("movies: \(movies.count)")
                      self?.movies = movies
                  })
            .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
}
