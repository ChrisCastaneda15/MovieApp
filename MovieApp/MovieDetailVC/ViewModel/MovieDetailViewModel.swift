//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/11/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
    let runtime: Int
    let mpaaRating: String
    let cast: [Actor]?
    let releaseYear: String
    let directedBy: String
    let rating: Double
    
    init(detail: MovieDetail) {
        runtime = detail.runtime
        mpaaRating = detail.certification
        cast = detail.cast
        releaseYear = detail.releaseYear
        directedBy = detail.directedBy?.joined(separator: ", ") ?? ""
        rating = detail.vote_avg ?? -1.0
    }
    
    func formattedRuntime()->String{
        var mins = runtime
        
        if runtime == 0 { return "" }
        
        mins = mins % 60
        let hours = (runtime - mins) / 60
        
        if hours <= 0 {return "\(mins)mins"}
        return "\(hours)h \(mins)mins"
    }
    
    func getTruncCast() -> [Actor]{
        var cast = [Actor]()
        if let actors = self.cast {
            var count = actors.count
            if count > 10 {count = 10}
            for actor in actors {
                //print("\(actor.characterName) - \(actor.actorName)")
                cast.append(actor)
                count -= 1
                if count == 0 {break}
            }
        }
        return cast
    }
}
