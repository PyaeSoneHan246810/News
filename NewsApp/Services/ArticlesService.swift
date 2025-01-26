//
//  ArticlesService.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

protocol ArticlesService {
    func getTopHeadlineArticlesByCategory(category: String) async throws -> [ArticleDto]
    
    func getRecommendedArticles(recommendation: String) async throws -> [ArticleDto]
    
    func getCategoryArticles(category: String, page: Int) async throws -> ResponseDto
    
    func searchArticles(query: String, page: Int) async throws -> ResponseDto
}

