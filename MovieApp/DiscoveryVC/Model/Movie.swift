//
//  Movie.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/7/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, overview, release_date, genre_ids, vote_average
        // Map img urls
        case backdrop_img = "backdrop_path"
        case poster_img = "poster_path"
    }
    
    let id: Int
    var title: String?
    let backdrop_img: String?
    let poster_img: String?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let vote_average: Double
}

public struct MovieGenre {
    static let order = [-1, 28, 12, 16, 35, 80, 99, 18, 10751, 14, 27, 10402, 9648, 10749, 878, 10770, 53, 10752, 37]
    
    static let dictionary = [
        -1 : "All",
        28 : "Action",
        12 : "Adventure",
        16 : "Animation",
        35 : "Comedy",
        80 : "Crime",
        99 : "Documentary",
        18 : "Drama",
        10751 : "Family",
        14 : "Fantasy",
        36 : "History",
        27 : "Horror",
        10402 : "Music",
        9648 : "Mystery",
        10749 : "Romance",
        878 : "Science Fiction",
        10770 : "TV Movie",
        53 : "Thriller",
        10752 : "War",
        37 : "Western"
    ]
    
    static let strings = {
        return order.map { genre in
            dictionary[genre] ?? ""
        }
    }
}
