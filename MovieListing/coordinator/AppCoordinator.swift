//
//  AppCoordinator.swift
//  MovieListing
//
//  Created by Salma on 22/07/2025.
//

import Foundation
import UIKit


class AppCoordinator {
    var navigationController: UINavigationController
    let storyboard = UIStoryboard(name: "Main", bundle: nil)


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = TopMoviesViewModel(movieService: MovieNetworkServiceImpl.shared)

        let topMoviesVC = storyboard.instantiateViewController(withIdentifier: "TopMoviesViewController") as! TopMoviesViewController
        topMoviesVC.viewModel = viewModel 

        navigationController.pushViewController(topMoviesVC, animated: true)
    }

}

