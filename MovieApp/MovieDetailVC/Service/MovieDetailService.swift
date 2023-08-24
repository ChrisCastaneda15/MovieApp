//
//  MovieDetailService.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/11/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieDetailService: NSObject {
    static let shared = MovieDetailService()
    
    func getIMDBid(for id: Int, completion: @escaping ([Media]?, Error?) -> ()) {
        AF.request(APIManager.URLS.BASE_URL + "movie/\(id)/external_ids?" + APIManager.key).response { response in
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                let results = json["results"]
                let movies = try JSONDecoder().decode([Media].self, from: try results.rawData())
                DispatchQueue.main.async {
                    completion(movies, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }
    }
    
    func getInfo(for id: Int, completion: @escaping (MovieDetail?, Error?) -> ()){
        AF.request(APIManager.URLS.MOVIE_DETAIL(with: id)).response { response in
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                print(response.request?.url?.absoluteString)
                //print(json)
                let runtime = json["runtime"].int
                let vote = json["vote_average"].double ?? -1.0
                
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
                
                var directors: [String]? = nil
                
                if let crewJson = json["credits"]["crew"].array {
                    directors = [String]()
                    for crew in crewJson {
                        if crew["department"] == "Directing" && crew["job"] == "Director"{
                            directors?.append(crew["name"].string ?? "N/A")
                        }
                    }
                }
                
                var releaseDate = json["release_date"].string ?? ""
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "yyyy"
                
                
                let dates = json["release_dates"]
                if let results = dates["results"].array {
                    for result in results {
                        if result["iso_3166_1"] == "US" {
                            if let dates = result["release_dates"].array {
                                for date in dates {
                                    let rating = date["certification"].string ?? "N/A"
                                    if rating != "" && rating != "N/A" {
                                    
                                        if let date = dateFormatterGet.date(from: releaseDate) {
                                            releaseDate = dateFormatterPrint.string(from: date)
                                        }
                                        DispatchQueue.main.async {
                                            completion(MovieDetail(runtime: runtime ?? 0, certification: rating, cast: cast, releaseYear: releaseDate, directedBy: directors, vote_avg: vote), nil)
                                            
                                        }
                                        return
                                    }
                                }
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    completion(MovieDetail(runtime: runtime ?? 0, certification: "N/A", cast: cast, releaseYear: releaseDate, directedBy: directors, vote_avg: vote), nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }
    }
    
}
