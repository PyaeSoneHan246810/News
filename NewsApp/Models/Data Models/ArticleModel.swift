//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Dylan on 01/01/2025.
//

import Foundation

struct ArticleModel: Identifiable, Hashable {
    
    let sourceId: String
    let sourceName: String
    let author: String
    let title: String
    let desc: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    
    var id: String { url }
}

extension ArticleModel {
    func toBookmarkArticleModel() -> BookmarkArticleModel {
        BookmarkArticleModel(
            sourceId: self.sourceId,
            sourceName: self.sourceName,
            author: self.author,
            title: self.title,
            desc: self.desc,
            url: self.url,
            urlToImage: self.urlToImage,
            publishedAt: self.publishedAt,
            content: self.content
        )
    }
    
    static func fromBookmarkArticleModel(_ bookmarkArticle: BookmarkArticleModel) -> ArticleModel {
        ArticleModel(
            sourceId: bookmarkArticle.sourceId,
            sourceName: bookmarkArticle.sourceName,
            author: bookmarkArticle.author,
            title: bookmarkArticle.title,
            desc: bookmarkArticle.desc,
            url: bookmarkArticle.url,
            urlToImage: bookmarkArticle.urlToImage,
            publishedAt: bookmarkArticle.publishedAt,
            content: bookmarkArticle.content
        )
    }
}
