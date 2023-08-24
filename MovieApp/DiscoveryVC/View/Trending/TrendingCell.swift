//
//  TrendingCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/26/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        trendingCollectionView.register(UINib(nibName: "TrendingMediaCell", bundle: nil), forCellWithReuseIdentifier: TrendingMediaCell.REUSE_ID)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension TrendingCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMediaCell.REUSE_ID, for: indexPath) as! TrendingMediaCell
        cell.mediaViewModel = mediaViewModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
         // 1
                   let index = indexPath.row
                   
                   // 2
                   let identifier = "\(index)" as NSString

                   let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                       print("Sharing \(self.mediaViewModels[index].title))")
                   }
                   
                   
                   return UIContextMenuConfiguration(
                     identifier: identifier,
                     previewProvider: nil) { _ in
                       return UIMenu(title: "\(self.mediaViewModels[index].title)", image: nil, children: [share])
                   }
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard
          // 1
          let identifier = configuration.identifier as? String,
          let index = Int(identifier),
          // 2
        
          let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? TrendingMediaCell
          else {
            return nil
        }
        
        // 3
        return UITargetedPreview(view: cell.backdropImgView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var media = self.mediaViewModels[indexPath.row]
        
        if media.type == .movie {
            self.navigationProtocol?.goToMovieDetail(for: media.convertToMovieViewModel())
        } else {
            print(media)
            self.navigationProtocol?.goToTVDetail(for: media.convertToTVViewModel())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard
          let identifier = configuration.identifier as? String,
          let index = Int(identifier)
          else {
            return
        }
        
        var media = self.mediaViewModels[index]
        
        // 3
        animator.addCompletion {
            if media.type == .movie {
                self.navigationProtocol?.goToMovieDetail(for: media.convertToMovieViewModel())
            } else {
                self.navigationProtocol?.goToTVDetail(for: media.convertToTVViewModel())
            }
        }
    }
}
