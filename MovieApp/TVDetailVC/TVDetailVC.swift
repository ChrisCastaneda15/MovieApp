//
//  TVDetailVC.swift
//  MovieApp
//
//  Created by Chris Castaneda on 9/25/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

class TVDetailVC: UIViewController {
    static var fromStoryboard: TVDetailVC {
        return UIStoryboard(name: "TVDetail", bundle: nil).instantiateViewController(withIdentifier: "TVDetail") as! TVDetailVC
    }
    
    @IBOutlet weak var posterContainer: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    @IBOutlet weak var showGenreLabel: UILabel!
    @IBOutlet weak var showRating_Runtime: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var castView: CCM_CastView!
    
    @IBOutlet weak var directorView: UIView!
    @IBOutlet weak var directorLabel: UILabel!
    
    var tvViewModel: TVViewModel!
    var detailViewModel: TVDetailModel!
    
    private final let CONST_CAST_SIZE: CGFloat = 200.0
    private final let CONST_DIR_SIZE: CGFloat = 40.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchDetail(with: tvViewModel.id)
    }
    
    private func setupView(){
        self.castView.isHidden = true
        self.descBottomConstraint.constant = self.descBottomConstraint.constant - (self.CONST_CAST_SIZE + self.CONST_DIR_SIZE)

        posterContainer.layer.cornerRadius = 10.0
        posterContainer.layer.shadowColor = UIColor(named: "Main")?.cgColor
        posterContainer.layer.shadowOffset = CGSize(width: 0, height: -5)
        posterContainer.layer.shadowRadius = 20.0
        posterContainer.layer.shadowOpacity = 0.9
          
        posterImageView.layer.cornerRadius = 10.0

        posterImageView.sd_setImage(with: URL(string: APIManager.IMAGES.getPosterImage(path: tvViewModel.posterImage, with: .small)), completed: nil)
        bgImageView.sd_setImage(with: URL(string: APIManager.IMAGES.getBackdropImage(path: tvViewModel.backdropImage, with: .large)), completed: nil)
        showNameLabel.text = tvViewModel.title
        
        //movieGenreLabel.text = MovieViewModel.genreString(from: movieViewModel.genreIds)
        descriptionTextView.text = tvViewModel.summary
        setRating(tvViewModel.rating)
    }
    
    fileprivate func fetchDetail(with id: Int){
        TVDetailService.shared.getInfo(for: id) { (detail, error) in
            if (error != nil) {
                return
            }
            
            print(detail)
            
            self.detailViewModel = TVDetailModel(item: detail!)
            
            if self.tvViewModel.rating == -1.0 || self.tvViewModel.rating == 0.0 {
                self.setRating(self.detailViewModel.vote_average)
            }
            
//
//            if self.directorLabel.text == "Director Yo"{
//                self.directorView.isHidden = true
//            } else {
//                self.descBottomConstraint.constant = self.descBottomConstraint.constant + self.CONST_DIR_SIZE
//            }
            
            self.directorLabel.text = detail?.creator
            
            print(self.descBottomConstraint.constant)
            
            print(self.detailViewModel.number_of_episodes)
            
            if self.detailViewModel.cast != nil {
                self.castView.isHidden = false
                self.descBottomConstraint.constant = self.descBottomConstraint.constant + self.CONST_CAST_SIZE
                //self.descBottomConstraint.constant = self.CONST_CAST_SIZE + self.CONST_DIR_SIZE
                
                self.castView.setCast(for: .tv, self.detailViewModel!)
            }
            
            print(self.descBottomConstraint.constant)
            
            var typeOfShow = "TV Series"
            if detail?.type != "Scripted" { typeOfShow = detail?.type ?? "N/A" }
            
            self.showRating_Runtime.text = "\(typeOfShow) \t \(detail!.years) \t \(detail!.tvRating)"
        }
    }
    
    private func setRating(_ rating:Double){
        if rating == -1.0 || rating == 0.0 {
            showRatingLabel.text = "N/A"
        } else {
            showRatingLabel.text = rating.description
        }
    }
    
}
