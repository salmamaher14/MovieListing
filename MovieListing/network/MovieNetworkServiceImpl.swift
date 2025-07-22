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
    
  /*  func fetchTopMovies() -> AnyPublisher<[Movie], any Error> {
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
        
    }*/
    
    func fetchTopMovies() -> AnyPublisher<[Movie], any Error> {
        print("🎬 Start fetching movies...")

        guard let url = URL(string: Constants.movies_url) else {
            print("❌ Invalid URL: \(Constants.movies_url)")
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Constants.api_key)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveSubscription: { _ in
                print("📡 Requesting movies from: \(url)")
            }, receiveOutput: { output in
                print("✅ Response received with status code: \((output.response as? HTTPURLResponse)?.statusCode ?? -1)")
                if let dataString = String(data: output.data, encoding: .utf8) {
                    print("🧾 Raw JSON: \(dataString.prefix(300))...") // print only first 300 chars
                }
            }, receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Successfully completed")
                case .failure(let error):
                    print("❌ Network error: \(error)")
                }
            })
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { movies in
                print("🎞️ Decoded \(movies.results.count) movies")
            })
            .map(\.results)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    
    
}

