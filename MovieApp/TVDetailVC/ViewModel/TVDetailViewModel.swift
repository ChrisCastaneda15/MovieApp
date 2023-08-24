//
//  TVDetailViewModel.swift
//  MovieApp
//
//  Created by Chris Castaneda on 11/3/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct TVDetailModel {
    let number_of_episodes: Int
    let number_of_seasons: Int
    //let certification: String
    let cast: [Actor]?
    let vote_average: Double
    
    init(item: TVDetail) {
        self.number_of_episodes = item.number_of_episodes
        self.number_of_seasons = item.number_of_seasons
        self.cast = item.cast
        self.vote_average = item.vote_average 
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
