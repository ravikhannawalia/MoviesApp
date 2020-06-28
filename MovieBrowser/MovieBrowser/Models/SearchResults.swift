//
//  SearchResults.swift
//  MovieBrowser
//
//  Created by Frontend on 6/23/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import Foundation
import Kingfisher

struct SearchResults: Decodable {
    
    var title: String?
    var id: Int?
    var posterUrl: String?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey{
        case title
        case id
        case posterURL = "poster_path"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        id = try values.decode(Int.self, forKey: .id)
        posterUrl = try values.decode(String.self, forKey: .posterURL)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
    }
    
    /*
     Takes Data from the following JSON file
     {
         "popularity": 28.406,
         "vote_count": 2467,
         "video": false,
         "poster_path": "/cAh2pCiNPftsY3aSqJuIOde7uWr.jpg",
         "id": 1903,
         "adult": false,
         "backdrop_path": "/wwLufumafJojc59hgIamHyJSTO9.jpg",
         "original_language": "en",
         "original_title": "Vanilla Sky",
         "genre_ids": [
             18,
             14,
             878,
             53,
             10749
         ],
         "title": "Vanilla Sky",
         "vote_average": 6.8,
         "overview": "David Aames has it all: wealth, good looks and gorgeous women on his arm. But just as he begins falling for the warmhearted Sofia, his face is horribly disfigured in a car accident. That's just the beginning of his troubles as the lines between illusion and reality, between life and death, are blurred.",
         "release_date": "2001-01-22"
     }
     */
}
