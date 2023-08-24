//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/11/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let runtime: Int
    let certification: String
    let cast: [Actor]?
    let releaseYear: String
    let directedBy: [String]?
    let vote_avg: Double?
}
