//
//  MoviesViewCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/7/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit

class MoviesViewCell: UITableViewCell {
    public static let REUSE_ID = "moviesCellReuse"

    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movieViewModels: [MovieViewModel] = [] {
        didSet {
            setupCollectionViews()
        }
    }
    
    fileprivate var GENRE_LIST = MovieGenre.order
    fileprivate var offset_dict = [Int:CGPoint]()
    fileprivate var genre_movie_dict = [Int:[MovieViewModel]]()
    
    private var selectedGenre = 0
    
    var navigationProtocol: NavigationProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        genreCollectionView.register(UINib(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: GenreCollectionCell.REUSE_ID)
        movieCollectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil), forCellWithReuseIdentifier: MovieCollectionCell.REUSE_ID)
    }

    fileprivate func fetchMovies(with Genre: Int?){
        if let dict = genre_movie_dict[GENRE_LIST[selectedGenre]] {
            self.movieViewModels = dict
            self.movieCollectionView.reloadData()
            self.movieCollectionView.setContentOffset(self.offset_dict[self.GENRE_LIST[self.selectedGenre]] ?? CGPoint(x: 0,y: 0), animated: false)
        } else {
            var g = Genre
            if g == -1 {
                g = nil
            }
            MovieService.shared.fetchMovies(with: g) { (movies, error) in
                if (error != nil) {
                    return
                }
                self.movieViewModels = movies?.map({return MovieViewModel(movie: $0)}) ?? []
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionViews(){
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.scrollToItem(at: IndexPath(item: selectedGenre, section: 0), at: .left, animated: true)
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.reloadData()
    }
}

extension MoviesViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 { return GENRE_LIST.count }
        return movieViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionCell.REUSE_ID, for: indexPath) as! GenreCollectionCell
            cell.genreName = MovieGenre.dictionary[GENRE_LIST[indexPath.row]]
            cell.isSelected = false
            if selectedGenre ==  indexPath.row { cell.isSelected = true }
            return cell
        } else if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.REUSE_ID, for: indexPath) as! MovieCollectionCell
            cell.movieViewModel = movieViewModels[indexPath.row]
            //registerForPreviewing(with: self, sourceView: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 0 { return 10 }
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: self.frame.width * 0.351, height: self.frame.height * 0.85)
        }
        return CGSize(width: 500, height: 33.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 { // GENRE COLLECTION
            //collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            if selectedGenre == indexPath.row {
                movieCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            } else {
                offset_dict[GENRE_LIST[selectedGenre]] = movieCollectionView.contentOffset
                genre_movie_dict[GENRE_LIST[selectedGenre]] = movieViewModels

                selectedGenre = indexPath.row
                fetchMovies(with: GENRE_LIST[selectedGenre])
            }
        } else if collectionView.tag == 1 { // MOVIE COLLECTION
            navigationProtocol?.goToMovieDetail(for: movieViewModels[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if collectionView.tag == 1 {
            // 1
            let index = indexPath.row
            
            // 2
            let identifier = "\(index)" as NSString

            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                print("Sharing \(self.movieViewModels[index].title))")
            }
            
            
            return UIContextMenuConfiguration(
              identifier: identifier,
              previewProvider: nil) { _ in
                return UIMenu(title: "\(self.movieViewModels[index].title)", image: nil, children: [share])
            }
            
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        if collectionView.tag == 1 {
            guard
              // 1
              let identifier = configuration.identifier as? String,
              let index = Int(identifier),
              // 2
            
              let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? MovieCollectionCell
              else {
                return nil
            }
            
            // 3
            return UITargetedPreview(view: cell.posterImageView)
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        if collectionView.tag == 1 {
            guard
              let identifier = configuration.identifier as? String,
              let index = Int(identifier)
              else {
                return
            }
            
            // 3
            animator.addCompletion {
                self.navigationProtocol?.goToMovieDetail(for: self.movieViewModels[index])
            }
        }
    }
}
