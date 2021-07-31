//
//  NewsStory.swift
//  Stocks
//
//  Created by DeQuan Douglas on 7/30/21.
//

import Foundation

struct NewsStory: Codable {

    let category: String
    let datetime: TimeInterval
    let headline: String
    //let id: 5085164
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
    
}
