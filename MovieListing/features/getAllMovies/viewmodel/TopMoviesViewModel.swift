//
//  TopMoviesViewModel.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
import Combine
import Reachability
import CoreData




protocol TopMoviesViewModelProtocol {
    var moviesPublisher: Published<[Movie]>.Publisher { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }

    var movies: [Movie] { get }
    func fetchMovies()
    func loadCachedMovies()
}


class TopMoviesViewModel: TopMoviesViewModelProtocol {
    private let movieService: MovieNetworkService
    private let reachability = try? Reachability()

    
    @Published private(set) var movies: [Movie] = []
    @Published var isLoading: Bool = false
    
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    var moviesPublisher: Published<[Movie]>.Publisher { $movies }

    init(movieService: MovieNetworkService) {
        self.movieService = movieService
    }


    func fetchMovies() {
        isLoading = true

        guard let reachability = reachability else {
            loadCachedMovies()
            isLoading = false
            return
        }

        if reachability.connection == .unavailable {
            print("No internet connection. Loading cached movies.")
            loadCachedMovies()
            isLoading = false
            return
        }

        // If movies already cached, we will skip api call
        if !MovieCoreData.shared.fetchAll().isEmpty {
            print("Using cached movies.")
            loadCachedMovies()
            isLoading = false
            return
        }

        movieService.fetchTopMovies()
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { [weak self] movies in
                guard let self = self else { return }
                self.movies = movies
                
                MovieCoreData.shared.deleteAll()
                for movie in movies {
                    MovieCoreData.shared.insert(movie: movie)
                }
            })
            .store(in: &cancellables)
    }
   
    // calling the api .
   /* func fetchMovies() {
        isLoading = true
        movieService.fetchTopMovies()
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { [weak self] movies in
                guard let self = self else { return }
                self.movies = movies
                
                MovieCoreData.shared.deleteAll()
                
                for movie in movies {
                    MovieCoreData.shared.insert(movie: movie)
                }
            })
            .store(in: &cancellables)
    }*/
    
    
    func loadCachedMovies() {
        let cachedMoviesData = MovieCoreData.shared.fetchAll()
        let cachedMovies = cachedMoviesData.map {
            Movie(
                id: Int($0.id),
                title: $0.title ?? "",
                posterPath: $0.poster_path ?? "",
                voteAverage: $0.vote_average,
                releaseDate: $0.release_date ?? "",
                overview: $0.overview ?? "",
                originalLanguage: $0.original_language ?? ""
            )
        }
        self.movies = cachedMovies
    }

    



    private var cancellables = Set<AnyCancellable>()
}


