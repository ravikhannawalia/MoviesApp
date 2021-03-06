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
    
    static let popularMoviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=6efc6c93672b8344194653f00432454f&language=en-US&sort_by=popularity.desc"
    
    static let searchUrlInitial = "https://api.themoviedb.org/3/search/movie?api_key=6efc6c93672b8344194653f00432454f&language=en-US&page=1&include_adult=true&query="
    
    static let imageURLInitial = "https://image.tmdb.org/t/p/w500/"
    
    static let imageURLInitial2 = "https://image.tmdb.org/t/p/w500"
    
    static let movieURLInitial = "https://api.themoviedb.org/3/movie/"
    
    
    static let genresURLInitial = "https://api.themoviedb.org/3/discover/movie?api_key=6efc6c93672b8344194653f00432454f&sort_by=popularity.desc&with_genres="
    
    static let genres = [
        "28": "Action",
        "12": "Adventure",
        "16": "Animation",
        "35": "Comedy",
        "80": "Crime",
        "99": "Documentary",
        "27": "Horror",
        "53": "Thriller",
        "10752": "War",
        "37": "Western"
        
    ]
}
