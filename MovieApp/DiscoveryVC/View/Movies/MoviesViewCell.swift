//
//  MoviesViewCell.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/7/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import UIKit
import SwiftUI

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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCellReuse", for: indexPath)
            let movieViewModel = movieViewModels[indexPath.row]
            cell.contentConfiguration = UIHostingConfiguration(content: {
                MovieCollectionCellView(
                    titleText: movieViewModel.title,
                    subtitleText: movieViewModel.genreString(),
                    posterImageUrl: movieViewModel.getPosterImgUrl()
                )
            })
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: self.frame.width * 0.35, height: self.frame.height * 0.75)
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

}
