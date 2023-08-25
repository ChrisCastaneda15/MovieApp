//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/7/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct MovieViewModel {
    var title: String
    var releaseDate: String
    let backdropImage: String
    let posterImage: String
    let genreIds: [Int]
    let summary: String
    let id: Int
    var releaseYear: Int
    var rating: Double
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.backdropImage = (movie.backdrop_img ?? "")
        self.posterImage = (movie.poster_img ?? "")
        self.genreIds = movie.genre_ids ?? [Int]()
        self.summary = movie.overview ?? ""
        self.id = movie.id
        self.rating = movie.vote_average
        
        let divisor = pow(10.0, Double(1.0))
        self.rating = (rating * divisor).rounded() / divisor
        
        self.releaseDate = movie.release_date ?? ""
        self.releaseYear = 0
        self.formatReleaseDate()
        
    }
    
    mutating func formatReleaseDate(){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        var dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy"

        if let date = dateFormatterGet.date(from: self.releaseDate) {
            self.releaseDate = dateFormatterPrint.string(from: date)
            
            dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy"
            self.releaseYear = Int(dateFormatterPrint.string(from: date))!
            
        } else { print("There was an error decoding the string") }
    }
    
    func genreString() -> String{
        var genreArry = [String]()
        
        for id in self.genreIds {
            genreArry.append(MovieGenre.dictionary[id] ?? "")
        }
        
        return genreArry.joined(separator: ", ")
    }
    
    func getPosterImgUrl(size: APIManager.IMAGES.ImageSize? = nil) -> URL? {
        return URL(string: APIManager.IMAGES.getPosterImage(path: self.posterImage, with: size ?? .medium))
    }
}
