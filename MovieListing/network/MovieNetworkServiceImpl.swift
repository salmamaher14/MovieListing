//
//  MovieNetworkServiceImpl.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
import Combine


class MovieNetworkServiceImpl: MovieNetworkService {
    
    static let shared = MovieNetworkServiceImpl()
    private init(){}
    
   func fetchTopMovies() -> AnyPublisher<[Movie], any Error> {
        print("here")
        guard let url = URL(string: Constants.movies_url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Constants.api_key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    


    
    
}

