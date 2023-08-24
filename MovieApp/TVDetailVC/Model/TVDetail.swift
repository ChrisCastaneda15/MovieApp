//
//  TVDetail.swift
//  MovieApp
//
//  Created by Chris Castaneda on 9/25/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TVDetail: Decodable {
    let number_of_episodes: Int
    let number_of_seasons: Int
    let creator: String
    let tvRating: String
    let type: String
    let years: String
    //let certification: String
    let cast: [Actor]?
    let vote_average: Double
}

//struct TVActor: Decodable {
//
//}
