//
//  TrendingCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/26/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftUI

class TrendingCell: UITableViewCell {
    public static let REUSE_ID = "trendingCellReuse"
    
    var mediaViewModels: [MediaViewModel] = [] {
        didSet {
            trendingCollectionView.delegate = self
            trendingCollectionView.dataSource = self
            trendingCollectionView.reloadData()
        }
    }
    
    var navigationProtocol: NavigationProtocol?
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TrendingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMediaCellReuse", for: indexPath)
        
        let mediaViewModel = mediaViewModels[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration(content: {
            TrendingMediaCell(
                subtitleText: mediaViewModel.releaseDate,
                titleText: mediaViewModel.title,
                backgroundImageUrl: mediaViewModel.getBackdropImgUrl()
            )
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var media = self.mediaViewModels[indexPath.row]
        if media.type == .movie {
            self.navigationProtocol?.goToMovieDetail(for: media.convertToMovieViewModel())
        } else {
            self.navigationProtocol?.goToTVDetail(for: media.convertToTVViewModel())
        }
    }
}
