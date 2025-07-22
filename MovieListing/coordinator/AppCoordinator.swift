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

/*
 class AppCoordinator {
     
     let navigationController: UINavigationController
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     
     init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

     func start() {
         // 1. Instantiate ViewModel
         let viewModel = TopMoviesViewModel() // or inject services if needed

         // 2. Instantiate VC from storyboard
         guard let vc = storyboard.instantiateViewController(
             identifier: "TopMoviesViewController") { coder in
                 return TopMoviesViewController(coder: coder, viewModel: viewModel)
             }
         else {
             return
         }

         // 3. Push it
         navigationController.pushViewController(vc, animated: true)
     }
 }

 */
