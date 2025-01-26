//
//  ResponseDto.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

struct ResponseDto: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
    
    let status: String
    let totalResults: Int
    let articles: [ArticleDto]
    
}
