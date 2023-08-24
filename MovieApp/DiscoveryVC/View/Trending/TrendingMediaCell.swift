//
//  TrendingMediaCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/26/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

class TrendingMediaCell: UICollectionViewCell {
    public static let REUSE_ID = "TrendingMediaCellReuse"
    
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var backdropImgView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var mediaViewModel: MediaViewModel! {
        didSet {
            mediaTitleLabel.text = mediaViewModel.title.uppercased()
            releaseDateLabel.text = mediaViewModel.releaseDate
            backdropImgView.layer.cornerRadius = 25.0
            backdropImgView.sd_setImage(with: URL(string: APIManager.IMAGES.getBackdropImage(path: mediaViewModel.backdropImage, with: 3)), completed: nil)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if traitCollection.forceTouchCapability != .available {
            UIView.animate(withDuration: 0.35) {
                self.backdropImgView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.mediaTitleLabel.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.releaseDateLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if traitCollection.forceTouchCapability != .available {
            UIView.animate(withDuration: 0.2) {
                self.backdropImgView.transform = CGAffineTransform.identity
                
                self.mediaTitleLabel.transform = CGAffineTransform.identity
                self.releaseDateLabel.transform = CGAffineTransform.identity
            }
        }
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if traitCollection.forceTouchCapability != .available {
            UIView.animate(withDuration: 0.2) {
                self.backdropImgView.transform = CGAffineTransform.identity

                self.mediaTitleLabel.transform = CGAffineTransform.identity
                self.releaseDateLabel.transform = CGAffineTransform.identity
            }
        }
        super.touchesCancelled(touches, with: event)
    }
}
