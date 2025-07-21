//
//  MovieTableViewCell.swift
//  MovieListing
//
//  Created by Salma on 21/07/2025.
//

import UIKit




class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    
    func configre(){
        moviePoster.image = UIImage(named: "movie_image")
    }


}

/*
 moviePoster.image = UIImage(named: "testPoster") // Use the name from Assets
}
 */
