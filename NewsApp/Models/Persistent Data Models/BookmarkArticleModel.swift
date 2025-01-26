//
//  BookmarkArticleModel.swift
//  NewsApp
//
//  Created by Dylan on 01/01/2025.
//

import Foundation
import SwiftData

@Model
class BookmarkArticleModel {
    
    var sourceId: String = ""
    var sourceName: String = ""
    var author: String = ""
    var title: String = ""
    var desc: String = ""
    @Attribute(.unique) var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    
    init(sourceId: String, sourceName: String, author: String, title: String, desc: String, url: String, urlToImage: String, publishedAt: String, content: String) {
        self.sourceId = sourceId
        self.sourceName = sourceName
        self.author = author
        self.title = title
        self.desc = desc
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
