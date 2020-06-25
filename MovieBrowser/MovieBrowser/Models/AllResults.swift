//
//  AllResults.swift
//  MovieBrowser
//
//  Created by Ravi Khannawalia on 25/06/20.
//  Copyright © 2020 Frontend. All rights reserved.
//

import Foundation
struct AllResults: Decodable {
    let page: Int?
    let results: [SearchResults]?
    let totalPages: Int?
  
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
