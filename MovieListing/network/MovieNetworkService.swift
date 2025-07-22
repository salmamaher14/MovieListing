//
//  MovieNetworkService.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
import Combine

protocol MovieNetworkService {
    func fetchTopMovies() -> AnyPublisher<[Movie], Error>

}
