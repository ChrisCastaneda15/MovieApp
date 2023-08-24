//
//  Movie.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/26/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct Media: Decodable {
    enum Media_type: String, Decodable {
        case movie, tv
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, media_type, overview, release_date, name, first_air_date
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
    let name: String?
    let media_type: Media_type
    let first_air_date: String?
    
    func convertToMovie() -> Movie{
        let movie = Movie(id: id, title: title, backdrop_img: backdrop_img, poster_img: poster_img, overview: overview, release_date: release_date, genre_ids: nil, vote_average: -1.0)
        return movie
    }
    
}
