//
//  Routes.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

enum HomeScreenRoutes: Routable {
    case home
    case search
    case articleDetails(articleModel: ArticleModel, zoomTransition: Namespace.ID)
    var body: some View {
        switch self {
        case .home: HomeScreenView()
        case .search: SearchScreenView()
        case .articleDetails(let articleModel, let zoomTransition): ArticleDetailsScreenView(
            articleModel: articleModel,
            zoomTransition: zoomTransition
        )
        }
    }
}

enum CategoriesScreenRoutes: Routable {
    case categories
    case categoryArticles(category: Category)
    case articleDetails(articleModel: ArticleModel, zoomTransition: Namespace.ID)
    var body: some View {
        switch self {
        case .categories: CategoriesScreenView()
        case .categoryArticles(let category): CategoryArticlesScreenView(category: category)
        case .articleDetails(let articleModel, let zoomTransition): ArticleDetailsScreenView(
            articleModel: articleModel,
            zoomTransition: zoomTransition
        )
        }
    }
}

enum BookmarksScreenRoutes: Routable {
    case bookmarks
    case articleDetails(articleModel: ArticleModel, zoomTransition: Namespace.ID)
    var body: some View {
        switch self {
        case .bookmarks: BookmarksScreenView()
        case .articleDetails(let articleModel, let zoomTransition): ArticleDetailsScreenView(
            articleModel: articleModel,
            zoomTransition: zoomTransition
        )
        }
    }
}

enum SettingsScreenRoutes: Routable {
    case settings
    var body: some View {
        switch self {
        case .settings: SettingsScreenView()
        }
    }
}
