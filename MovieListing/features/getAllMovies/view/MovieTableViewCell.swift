//
//  MovieTableViewCell.swift
//  MovieListing
//
//  Created by Salma on 21/07/2025.
//


import UIKit
import Kingfisher
import Cosmos

class MovieTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var moviePoster: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieDate: UILabel!
    @IBOutlet private weak var movieRating: UIView!
    @IBOutlet weak var favButton: UIButton!
    
    private var isFavorited = false
    private var cosmosView: CosmosView?

    func configure(with movie: Movie) {
        configureTitle(movie.title)
        configureDate(movie.releaseDate)
        configurePoster(movie.posterPath)
        configureRating(movie.voteAverage)
        updateFavButtonUI()
        
    }

    // MARK: - Private Configuration Helpers
    private func configureTitle(_ title: String?) {
        movieTitle.text = title
    }

    private func configureDate(_ date: String?) {
        movieDate.text = date
    }

    private func configurePoster(_ posterPath: String?) {
        moviePoster.layer.cornerRadius = 10
        
        let placeholder = UIImage(systemName: "film")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        
        if let posterPath = posterPath,
           let url = URL(string: Constants.poster_url + posterPath) {
            moviePoster.kf.setImage(with: url, placeholder: placeholder)
        } else {
            moviePoster.image = placeholder
        }
    }


    private func configureRating(_ rating: Double) {

        cosmosView?.removeFromSuperview()

        let cosmos = CosmosView()
        cosmos.settings.updateOnTouch = false
        cosmos.rating = rating
        cosmos.frame = movieRating.bounds
        cosmos.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        movieRating.addSubview(cosmos)
        cosmosView = cosmos
    }
    
    private func updateFavButtonUI() {
        let imageName = isFavorited ? "heart.fill" : "heart"
        favButton.setImage(UIImage(systemName: imageName), for: .normal)
        favButton.tintColor = isFavorited ? UIColor(named: "main_color") : .gray
    }


    @IBAction private func btn_fav(_ sender: Any) {
        isFavorited.toggle()
        updateFavButtonUI()
    }
}

