//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/9/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit


class MovieDetailVC: UIViewController {
    static var fromStoryboard: MovieDetailVC {
        return UIStoryboard(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailVC
    }
    
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieRating_Runtime: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var castView: CCM_CastView!
    
    @IBOutlet weak var directorView: UIView!
    @IBOutlet weak var directorLabel: UILabel!
    
    private final let CONST_CAST_SIZE: CGFloat = 200.0
    private final let CONST_DIR_SIZE: CGFloat = 40.0
    
    var movieViewModel: MovieViewModel!
    var mDVM: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchDetail(with: movieViewModel.id)
    }
    
    fileprivate func fetchDetail(with id: Int){
        MovieDetailService.shared.getInfo(for: id) { (detail, error) in
            if (error != nil) {
                return
            }
            
            self.mDVM = MovieDetailViewModel(detail: detail!)
            
            if self.movieViewModel.rating == -1.0 || self.movieViewModel.rating == 0.0 {
                self.setRating(self.mDVM.rating)
            }
            
            self.directorLabel.text = self.mDVM.directedBy
            
            if self.directorLabel.text == "Director Yo"{
                self.directorView.isHidden = true
            } else {
                self.descBottomConstraint.constant = self.descBottomConstraint.constant + self.CONST_DIR_SIZE
            }
            
            print(self.descBottomConstraint.constant)
            
            if self.mDVM.cast != nil {
                self.castView.isHidden = false
                self.descBottomConstraint.constant = self.descBottomConstraint.constant + self.CONST_CAST_SIZE
                //self.descBottomConstraint.constant = self.CONST_CAST_SIZE + self.CONST_DIR_SIZE
                
                self.castView.setCast(for: .movie, self.mDVM!)
            }
            
            print(self.descBottomConstraint.constant)
            
            self.movieRating_Runtime.text = "\(self.mDVM.releaseYear) \t \(self.mDVM.mpaaRating) \t \(self.mDVM.formattedRuntime())"
        }
    }
    
    private func setupView(){
        self.castView.isHidden = true
        self.descBottomConstraint.constant = self.descBottomConstraint.constant - (self.CONST_CAST_SIZE + self.CONST_DIR_SIZE)
        
        bgView.layer.cornerRadius = 10
        bgView.layer.shadowColor = UIColor(named: "Main")?.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.0, height : -25.0)
        bgView.layer.shadowOpacity = 0.8
        bgView.layer.shadowRadius = 20
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10.0
        posterImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        posterImageView.sd_setImage(with: URL(string: APIManager.IMAGES.getPosterImage(path: movieViewModel.posterImage, with: .large)), completed: nil)
        
        movieNameLabel.text = movieViewModel.title
        movieGenreLabel.text = MovieViewModel.genreString(from: movieViewModel.genreIds)
        descriptionTextView.text = movieViewModel.summary
        setRating(movieViewModel.rating)
    }
    
    private func setRating(_ rating:Double){
        if rating == -1.0 || rating == 0.0 {
            movieRatingLabel.text = "N/A"
        } else {
            movieRatingLabel.text = rating.description
        }
    }
}


