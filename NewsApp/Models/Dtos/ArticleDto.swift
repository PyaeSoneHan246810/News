//
//  ArticleDto.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import Foundation

struct ArticleDto: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    
    let source: SourceDto?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

}

extension ArticleDto {
    func toArticleModel() -> ArticleModel {
        ArticleModel(
            sourceId: self.source?.id ?? "",
            sourceName: self.source?.name ?? "Unknown Source Name",
            author: self.author ?? "Unknown Author",
            title: self.title ?? "Unknown Title",
            desc: self.description ?? "Empty Description",
            url: self.url ??  "",
            urlToImage: self.urlToImage ?? "",
            publishedAt: self.publishedAt ?? "",
            content: self.content ?? "Empty Content"
        )
    }
}
