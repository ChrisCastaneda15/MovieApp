//
//  APIManager.swift
//  MovieApp
//
//  Created by Chris Castaneda on 6/11/20.
//  Copyright © 2020 Chris Castaneda. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    static let key = "ab1de41bb88d10e3529c0eba12617b95"
    
    // MARK: - Structs
    public struct URLS {
        static let BASE_URL = "https://api.themoviedb.org/3"
        static let KEY_PARAM = "api_key=" + key
        
        static let TRENDING = URLS.BASE_URL + "/trending/all/day?" + URLS.KEY_PARAM
        static let MOVIES = URLS.BASE_URL + "/discover/movie?" + URLS.KEY_PARAM + "&language=en-US&region=US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
        
        private static let MEDIA_DETAIL = "?\(URLS.KEY_PARAM)&language=en-US&append_to_response=release_dates%2Ccredits"
        static func MOVIE_DETAIL(with id: Int) -> String{
            return URLS.BASE_URL + "/movie/" + "\(id)" + MEDIA_DETAIL
        }
        
        static func TV_DETAIL(with id: Int) -> String{
            return URLS.BASE_URL + "/tv/" + "\(id)" + MEDIA_DETAIL + "%2Ccontent_ratings"
        }
    }
    
    public struct IMAGES {
        private static let IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/"
        
        static func getBackdropImage(path: String, with size: Int) -> String{
            var imgsize = ""
            switch size {
            case 1: // SMALL : 300
                imgsize = "w300"
            case 2: // MED : 780
                imgsize = "w780"
            case 3: // LARGE : 1280
                imgsize = "w1280"
            default: // ORIGINAL
                imgsize = "original"
            }
            return IMAGES.IMAGE_BASE_PATH + imgsize + path
        }
        
    
        
        //MARK: - Funcs
        
        public static func getPosterImage(path: String, with size: Int) -> String{
            var imgsize = ""
            switch size {
            case 1: // SMALL : 342
                imgsize = "w342"
            case 2: // MED : 500
                imgsize = "w500"
            case 3: // LARGE : 780
                imgsize = "w780"
            default: // ORIGINAL
                imgsize = "original"
            }
            return IMAGES.IMAGE_BASE_PATH + imgsize + path
        }
        
        public static func getCastPhoto(path: String, with size: Int) -> String{
            var imgsize = ""
            switch size {
            case 1: // SMALL : 342
                imgsize = "w342"
            case 2: // MED : 500
                imgsize = "w500"
            case 3: // LARGE : 780
                imgsize = "w780"
            default: // ORIGINAL
                imgsize = "original"
            }
            return IMAGES.IMAGE_BASE_PATH + imgsize + path
        }
    }
    
    public struct MOVIE_DATA {
        static fileprivate let movie_dict = [
            299534 : "ENDGAME", // ENDGAME
            671 : "HARRY POTTER 1", // HARRY POTTER 1
            680 : "PULP FICTION", // PULP FICTION
        ]
        
        public static func hasVideo(for id: Int) -> String?{
            return movie_dict[id]
        }
    }
}
