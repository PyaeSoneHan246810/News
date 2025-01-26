//
//  HomeScreenView-ViewModel.swift
//  NewsApp
//
//  Created by Dylan on 02/01/2025.
//

import Foundation
import Observation

extension HomeScreenView {
    @MainActor
    @Observable
    class ViewModel {
        // MARK: - PROPERTIES
        let articlesService: ArticlesService
        
        // MARK: - STATE PROPERTIES
        var topHeadlineArticlesState: DataState<[ArticleModel]> = .loading
        var recommendedArticlesState: DataState<[ArticleModel]> = .loading
        var recommendation = Constants.recommendedQueries.randomElement()!
        
        // MARK: - INITIALIZER
        init(articlesService: ArticlesService) {
            self.articlesService = articlesService
        }
        
        // MARK: - FUNCTIONS
        func getTopHeadlineArticles(category: String) async {
            self.topHeadlineArticlesState = .loading
            do {
                let articleDtos = try await articlesService.getTopHeadlineArticlesByCategory(category: category)
                let articleModels = articleDtos.map { articleDto in
                    articleDto.toArticleModel()
                }
                self.topHeadlineArticlesState = .loaded(articleModels)
            } catch {
                self.topHeadlineArticlesState = .error(error)
            }
            
        }
        func getRecommendedArticles() async {
            self.recommendedArticlesState = .loading
            do {
                let articleDtos = try await articlesService.getRecommendedArticles(
                    recommendation: recommendation
                )
                let articleModels = articleDtos.map { articleDto in
                    articleDto.toArticleModel()
                }
                self.recommendedArticlesState = .loaded(articleModels)
            } catch {
                self.recommendedArticlesState = .error(error)
            }
        }
    }
}
