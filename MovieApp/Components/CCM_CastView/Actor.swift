//
//  Actor.swift
//  MovieApp
//
//  Created by Chris Castaneda on 8/30/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

struct Actor: Decodable {
    let characterName: String
    let imgPath: String
    let actorName: String
    let id: Int
}
