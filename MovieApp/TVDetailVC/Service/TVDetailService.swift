//
//  TVDetailService.swift
//  MovieApp
//
//  Created by Chris Castaneda on 9/25/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TVDetailService: NSObject {
    static let shared = TVDetailService()
    
    func getInfo(for id: Int, completion: @escaping (TVDetail?, Error?) -> ()){
        AF.request(APIManager.URLS.TV_DETAIL(with: id)).response { response in
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                print(response.request?.url?.absoluteString)
                //print(json)
                let numEp = json["number_of_episodes"].int
                let numSeason = json["number_of_seasons"].int
                let vote = json["vote_average"].double ?? -1.0
                let type = json["type"].string
                
                // Calculate active years
                let status = json["status"].string
                
                let first_air_year = (json["first_air_date"].string)!.prefix(4)
                let last_air_year = (json["last_air_date"].string)!.prefix(4)
                
                var yearsActive = "\(first_air_year)-"
                
                if status == "Ended" { yearsActive = yearsActive + last_air_year }
                
                // Created By string
                
                var createdBy: String = "N/A"
                
                if let createdByArrJson = json["created_by"].array {
                    var createdByArr: [String] = []
                    
                    for creatorObj in createdByArrJson {
                        createdByArr.append(creatorObj["name"].string ?? "N/A")
                    }
                    
                    switch createdByArr.count {
                    case 1:
                        createdBy = createdByArr[0]
                    case 2:
                        createdBy = "\(createdByArr[0]) & \(createdByArr[1])"
                    default:
                        let lastCreator = createdByArr.popLast()
                        createdBy = createdByArr.joined(separator: ", ")
                        createdBy = createdBy + ", & \(lastCreator ?? "")"
                    }
                    
                    
                }
                
                var cast: [Actor]? = nil
                
                if let castJson = json["credits"]["cast"].array {
                    cast = [Actor]()
                    for actor in castJson {
                        var character = actor["character"].string ?? "N/A"
                        if character == "" {character = "N/A"}
                        let actorName = actor["name"].string ?? "N/A"
                        let img = actor["profile_path"].string ?? ""
                        let id = actor["id"].int ?? -1
                        
                        cast!.append(Actor(characterName: character, imgPath: img, actorName: actorName, id: id))
                    }
                }
                
                var tvRating = "N/A"
                
                if let tvRatingJson = json["content_ratings"]["results"].array {
                    for rating in tvRatingJson {
                        if rating["iso_3166_1"].string == "US" {
                            tvRating = rating["rating"].string ?? "N/A"
                            break
                        }
                        continue
                    }
                }
                
                
                DispatchQueue.main.async {
                    let deet = TVDetail(number_of_episodes: numEp ?? 0, number_of_seasons: numSeason ?? 0, creator: createdBy, tvRating: tvRating, type: type ?? "N/A", years: yearsActive, cast: cast, vote_average: vote)
                    completion(deet, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }
    }
    
}
