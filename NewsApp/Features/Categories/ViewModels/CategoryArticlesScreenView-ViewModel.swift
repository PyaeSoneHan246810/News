//
//  CategoryArticlesScreenView-ViewModel.swift
//  NewsApp
//
//  Created by Dylan on 02/01/2025.
//

import Foundation
import Observation

extension CategoryArticlesScreenView {
    @Observable
    class ViewModel {
        // MARK: - PROPERTIES
        let articlesService: ArticlesService
        var currentCategoryArticlesPage: Int = 1
        private(set) var categoryArticles: [ArticleModel] = []
        private(set) var categoryArticlesTotalResult: Int = 0
        private(set) var errorMessage: String?
        
        // MARK: - INITIALIZER
        init(articlesService: ArticlesService) {
            self.articlesService = articlesService
        }
        
        // MARK: - FUNCTIONS
        func getCategoryArticles(category: String) async {
            errorMessage = nil
            do {
                let responseDto = try await articlesService.getCategoryArticles(
                    category: category,
                    page: currentCategoryArticlesPage
                )
                let articleModels = responseDto.articles.map { articleDto in
                    articleDto.toArticleModel()
                }
                self.categoryArticles.append(contentsOf: articleModels)
                self.categoryArticlesTotalResult = responseDto.totalResults
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
            
        }
    }
}
