//
//  TVViewModel.swift
//  MovieApp
//
//  Created by Chris Castaneda on 3/27/21.
//  Copyright © 2021 Chris Castaneda. All rights reserved.
//

import Foundation

struct TVViewModel {
    var title: String
    var releaseDate: String
    let backdropImage: String
    let posterImage: String
    let genreIds: [Int]
    let summary: String
    let id: Int
    var releaseYear: Int
    var rating: Double
    
    init(item: Media) {
        self.title = item.name ?? ""
        self.backdropImage = (item.backdrop_img ?? "")
        self.posterImage = (item.poster_img ?? "")
        self.genreIds = [Int]()
        self.summary = item.overview ?? ""
        self.id = item.id
        self.rating = 0.0
        
        let divisor = pow(10.0, Double(1.0))
        self.rating = (rating * divisor).rounded() / divisor
        
        self.releaseDate = item.first_air_date ?? ""
        self.releaseYear = 0
        self.formatReleaseDate()
        
    }
    
    init(tv: Television) {
        self.title = tv.name ?? ""
        self.backdropImage = (tv.backdrop_img ?? "")
        self.posterImage = (tv.poster_img ?? "")
        self.genreIds = tv.genre_ids ?? [Int]()
        self.summary = tv.overview ?? ""
        self.id = tv.id
        self.rating = tv.vote_average
        
        let divisor = pow(10.0, Double(1.0))
        self.rating = (rating * divisor).rounded() / divisor
        
        self.releaseDate = tv.first_air_date ?? ""
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
    
    static func genreString(from ids: [Int]) -> String{
        var genreArry = [String]()
        
        for id in ids {
            genreArry.append(MovieGenre.dictionary[id] ?? "")
        }
        
        return genreArry.joined(separator: ", ")
    }
}

