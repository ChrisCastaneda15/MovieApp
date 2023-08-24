//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/26/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct MediaViewModel {
    private let media: Media
    
    var title: String
    var releaseDate: String
    let backdropImage: String
    let posterImage: String
    let type: Media.Media_type
    let id: Int
    
    init(item: Media) {
        self.media = item
        self.id = item.id
        
        self.title = item.title ?? ""
        self.backdropImage = (item.backdrop_img ?? "")
        self.posterImage = (item.poster_img ?? "")
        self.type = item.media_type
        
        self.releaseDate = item.release_date ?? ""
        if item.media_type == .tv {
            self.title = item.name!
            self.releaseDate = item.first_air_date!
        }
        self.formatReleaseDate()
        
    }
    
    mutating func formatReleaseDate(){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy"

        if let date = dateFormatterGet.date(from: self.releaseDate) {
            self.releaseDate = dateFormatterPrint.string(from: date)
        } else { print("There was an error decoding the string") }
    }
    
    mutating func convertToMovieViewModel() -> MovieViewModel{
        let mvm = MovieViewModel(movie: media.convertToMovie())
        return mvm
    }
    
    func convertToTVViewModel() -> TVViewModel {
        let tvvm = TVViewModel(item: media)
        return tvvm
    }
    
    func getBackdropImgUrl() -> URL? {
        return URL(string: APIManager.IMAGES.getPosterImage(path: self.backdropImage, with: 3))
    }
}
