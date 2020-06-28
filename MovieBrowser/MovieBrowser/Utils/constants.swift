//
//  constants.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 28/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import Foundation

struct Constants{
    static let apiKey = "?api_key=6efc6c93672b8344194653f00432454f"
    
    static let popularMoviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=6efc6c93672b8344194653f00432454f&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1"
    
    static let searchUrlInitial = "https://api.themoviedb.org/3/search/movie?api_key=6efc6c93672b8344194653f00432454f&language=en-US&page=1&include_adult=true&query="
    
    static let imageURLInitial = "https://image.tmdb.org/t/p/w500/"
    
    static let movieURLInitial = "https://api.themoviedb.org/3/movie/"
}
