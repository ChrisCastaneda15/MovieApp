//
//  CastCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/31/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit
import SDWebImage

class CastCell: UICollectionViewCell {
    public static let REUSE_ID = "CastCellReuse"
    
    @IBOutlet weak var castPhoto: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var actorName: UILabel!
    
    var actorModel: Actor? {
        didSet {
            setupCell()
        }
    }
    
    override func draw(_ rect: CGRect) {
        castPhoto.layer.cornerRadius = castPhoto.frame.height / 2
    }
    
    private func setupCell(){
        if let actor = actorModel {
            characterName.text = actor.characterName
            actorName.text = actor.actorName
            let imgUrl = URL(string: APIManager.IMAGES.getCastPhoto(path: actor.imgPath, with: 1))
            castPhoto.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "cast_placeholder"), options: SDWebImageOptions(), completed: nil)
            castPhoto.tintColor = UIColor.mainTextColor            
        }
    }
    
}
