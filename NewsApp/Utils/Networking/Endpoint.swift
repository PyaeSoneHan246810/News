//
//  Endpoint.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

enum Endpoint {
    case topHeadlinesArticles(category: String)
    case recommendedArticles(query: String)
    case categoryArticles(category: String, page: Int)
    case searchArticles(query: String, page: Int)
    var path: String {
        switch self {
        case .topHeadlinesArticles(let category):
            "/top-headlines?category=\(category)"
        case .recommendedArticles(let query):
            "/everything?q=\(query)"
        case .categoryArticles(let category, let page):
            "/top-headlines?category=\(category)&page=\(page)"
        case .searchArticles(let query, let page):
            "/everything?q=\(query)&page=\(page)"
        }
    }
}
