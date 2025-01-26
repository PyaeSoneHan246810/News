//
//  Constants.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

class Constants {
    static let categories: [Category] = [
        Category(emoji: "✨", name: "General"),
        Category(emoji: "💲", name: "Business"),
        Category(emoji: "🎵", name: "Entertainment"),
        Category(emoji: "🩺", name: "Health"),
        Category(emoji: "🔬", name: "Science"),
        Category(emoji: "🏈", name: "Sports"),
        Category(emoji: "💻", name: "Technology"),
    ]
    
    static let recommendedQueries: [String] = [
        "bitcoin",
        "election",
        "football",
        "programming",
        "climate",
        "artificial intelligence",
        "startup",
        "innovations",
        "space",
        "history"
    ]
    
    static let baseURL: String = "https://newsapi.org/v2"
    
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "Api_key") as? String ?? ""
}
