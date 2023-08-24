//
//  MovieCollectionCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/7/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    public static let REUSE_ID = "MovieCollectionCellReuse"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    
    var movieViewModel: MovieViewModel! {
        didSet {
            movieTitleLabel.text = movieViewModel.title
            movieGenresLabel.text = MovieViewModel.genreString(from: movieViewModel.genreIds)
            movieGenresLabel.sizeToFit()
            posterImageView.layer.cornerRadius = 25.0
            posterImageView.sd_setImage(with: URL(string: APIManager.IMAGES.getPosterImage(path: movieViewModel.posterImage, with: 2)), completed: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if traitCollection.forceTouchCapability != .available {
            UIView.animate(withDuration: 0.35) {
                self.posterImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if traitCollection.forceTouchCapability != .available {
            UIView.animate(withDuration: 0.2) {
                self.posterImageView.transform = CGAffineTransform.identity
            }
        }
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if traitCollection.forceTouchCapability != .available {UIView.animate(withDuration: 0.2) {
                self.posterImageView.transform = CGAffineTransform.identity
                
            }
        }
        super.touchesCancelled(touches, with: event)
    }
}
