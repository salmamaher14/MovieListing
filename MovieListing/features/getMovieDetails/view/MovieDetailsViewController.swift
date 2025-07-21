//
//  MovieDetailsViewController.swift
//  MovieListing
//
//  Created by Salma on 21/07/2025.
//



import UIKit
import UIImageColors

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!

    private var backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let poster = UIImage(named: "oppenheimer") {
            let backgroundImageView = UIImageView(image: poster)
            backgroundImageView.frame = backgroundView.bounds
            backgroundView.addSubview(backgroundImageView)

            let blurEffect = UIBlurEffect(style: .dark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = backgroundView.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundView.addSubview(blurView)

            posterImage.image = poster
            backgroundView.addSubview(posterImage)
        }
    }



}
