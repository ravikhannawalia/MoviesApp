//
//  MovieDBService.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 28/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import Foundation
import Alamofire

let apiKey = ""

enum ApiException{
    case searchURLException
    case responseException
    case moviesDecodeException
}

enum QueryType{
    case allResults
    case movie
}

class MovieDBService{
    func fetchAllResults(searchString: String, page: Int = 1, completion: @escaping (_ results: [SearchResults]?,_ error: ApiException?) -> Void){
        
        guard let dataUrlString = apiURL(searchString, page: page, .allResults) else {
            completion(nil, .searchURLException)
          return
        }
        
        AF.request(dataUrlString)
            .validate()
            .responseDecodable(of: AllResults.self){ response in
                guard let movies = response.value else {
                    completion(nil, .responseException)
                    return
                }
                guard let results = movies.results else {
                    completion(nil, .moviesDecodeException)
                    return
                }
                completion(results, nil)
            }
    }
    
    func fetchMovieInfo(id: String, completion: @escaping (_ results: Movie?,_ error: ApiException?) -> Void){
        
        guard let dataUrlString = apiURL(id, .movie) else {
            completion(nil, .searchURLException)
          return
        }
        
        AF.request(dataUrlString)
            .validate()
            .responseDecodable(of: Movie.self){ response in
            guard let movie = response.value else {
                completion(nil, .responseException)
                return
            }
            completion(movie, nil)
        }
    }
    
    //MARK: Private functions
    func apiURL(_ searchTerm: String, page: Int = 1, _ queryType: QueryType) -> String? {
        
        guard let escapedTerm = "".addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else {
            return nil
        }
        var urlString: String
        switch queryType {
        case .allResults:
            urlString = searchTerm + escapedTerm + "&page=" + String(page)
        case .movie:
            urlString = Constants.movieURLInitial + searchTerm + Constants.apiKey
        }
        
      return urlString
    }
}
