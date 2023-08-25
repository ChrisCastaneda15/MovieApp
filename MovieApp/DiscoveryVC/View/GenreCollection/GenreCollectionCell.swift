//
//  GenreCollectionCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/8/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
    public static let REUSE_ID = "GenreCollectionCellReuse"
    
    @IBOutlet weak var genreLabel: UILabel!
    
    var genreName: String! {
        didSet {
            if genreName == "" {
                genreName = "    "
                self.isUserInteractionEnabled = true
            }
            genreLabel.text = genreName
        }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                genreLabel.textColor = UIColor(named: "text")
            } else {
                genreLabel.textColor = .gray
            }
        }
    }
}
