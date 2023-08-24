//
//  MovieService.swift
//  MovieApp
//
//  Created by Chris Castaneda on 5/26/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieService: NSObject {
    static let shared = MovieService()
    
    // MARK: - Functions
    func fetchTrending(completion: @escaping ([Media]?, Error?) -> ()) {
        AF.request(APIManager.URLS.TRENDING).response { response in
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

    func fetchMovies(with genreID: Int?, completion: @escaping ([Movie]?, Error?) -> ()){
        var movie_url = APIManager.URLS.MOVIES
        if let genre = genreID { movie_url += "&with_genres=\(genre)" }
        AF.request(movie_url).response { response in
            guard let data = response.data else { return }
            do {
                let json = try JSON(data: data)
                let results = json["results"]
                let movies = try JSONDecoder().decode([Movie].self, from: try results.rawData())
                DispatchQueue.main.async {
                    completion(movies, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }
    }
}
