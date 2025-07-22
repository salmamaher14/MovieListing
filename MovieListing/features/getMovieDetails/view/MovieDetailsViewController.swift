//
//  MovieDetailsViewController.swift
//  MovieListing
//
//  Created by Salma on 21/07/2025.
//

//
//  MovieDetailsViewController.swift
//  MovieListing
//
//  Created by Salma on 21/07/2025.
//

import UIKit
import Kingfisher
import Cosmos

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UIView!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieOverview: UITextView!

    private let backgroundImageView = UIImageView()
    private var cosmosView: CosmosView?
    private var isFavorited = false
    var viewmodel: MovieDetailsViewmodelProtocol?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateFavButtonUI()
        setUpUI()
    }

    private func setUpUI() {
        setUpPoster()
        setUpMovieData()
    }

    private func setUpPoster() {
        guard let posterPath = viewmodel?.getSelectedMovie().posterPath,
              let url = URL(string: Constants.poster_url + posterPath) else {
            return
        }

        backgroundImageView.kf.setImage(with: url) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                self.configureBackgroundImage()
                self.setPosterImage(url: url)
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }

    private func configureBackgroundImage() {
        backgroundImageView.frame = backgroundView.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundView.addSubview(backgroundImageView)

        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurView)
    }

    private func setPosterImage(url: URL) {
        posterImage.kf.setImage(with: url)
     
        backgroundView.addSubview(posterImage)
    }

    private func setUpMovieData() {
        guard let movie = viewmodel?.getSelectedMovie() else { return }

        movieTitle.text = movie.title
        movieLanguage.text = movie.originalLanguage.uppercased()
        movieOverview.text = movie.overview
        voteAverage.text = "\(movie.voteAverage)/10"
        
        configureRating(movie.voteAverage)

        
        
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

    
    @IBAction func fav_btn(_ sender: Any) {
        isFavorited.toggle()
        updateFavButtonUI()
    }
}
