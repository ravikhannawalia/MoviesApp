//
//  Movie.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 28/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String?
    let id: Int?
    let overview: String?
    let posterURL: String?
  
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case id
        case overview
        case posterURL = "backdrop_path"
    }
    
    /*
     {
         "adult": false,
         "backdrop_path": "/a1Owc5J5MZ8YlVCiR4sKO211Njd.jpg",
         "belongs_to_collection": null,
         "budget": 0,
         "genres": [],
         "homepage": "https://www.bobbyfodera.com/stories-from-sicily",
         "id": 718175,
         "imdb_id": null,
         "original_language": "en",
         "original_title": "Stories from Sicily",
         "overview": "A documentary about the life of the filmmaker’s grandfather and his life growing up in Fascist Italy to meeting his wife and immigrating to America.",
         "popularity": 0.63,
         "poster_path": "/zjfi4jM8SDOEL4CgrWSVKRvH6Jt.jpg",
         "production_companies": [],
         "production_countries": [],
         "release_date": "2020-02-21",
         "revenue": 0,
         "runtime": 11,
         "spoken_languages": [
             {
                 "iso_639_1": "en",
                 "name": "English"
             }
         ],
         "status": "Released",
         "tagline": "",
         "title": "Stories from Sicily",
         "video": false,
         "vote_average": 10,
         "vote_count": 1
     }
     */
}
