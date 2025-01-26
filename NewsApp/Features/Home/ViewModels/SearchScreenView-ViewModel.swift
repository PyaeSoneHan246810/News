//
//  SearchScreenView-ViewModel.swift
//  NewsApp
//
//  Created by Dylan on 07/01/2025.
//

import Foundation
import Observation

extension SearchScreenView {
    @MainActor
    @Observable
    class ViewModel {
        
        // MARK: - PROPERTIES
        let articlesService: ArticlesService
        var searchQuery: String = ""
        var currentSearchArticlesPage: Int = 1
        private(set) var searchArticles: [ArticleModel] = []
        private(set) var searchArticlesTotalResult: Int = 0
        private(set) var searchState: SearchState = .idle
        private(set) var errorMessage: String?
        
        // MARK: - INITIALIZER
        init(articlesService: ArticlesService) {
            self.articlesService = articlesService
        }
        
        // MARK: - FUNCTIONS
        func searchArticles() async {
            searchState = .searching
            do {
                let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
                let responseDto = try await articlesService.searchArticles(
                    query: query,
                    page: currentSearchArticlesPage
                )
                let articleModels = responseDto.articles.map { articleDto in
                    articleDto.toArticleModel()
                }
                self.searchArticles.append(contentsOf: articleModels)
                self.searchArticlesTotalResult = responseDto.totalResults
                searchState = .searched
            } catch {
                searchState = .failed
                errorMessage = error.localizedDescription
            }
        }
        func resetSearchArticlesStates() {
            self.searchArticles.removeAll()
            self.searchArticlesTotalResult = 0
            self.currentSearchArticlesPage = 1
        }
    }
}
