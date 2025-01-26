//
//  CategoryArticlesScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

struct CategoryArticlesScreenView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @EnvironmentObject private var categoriesScreenRouter: Router<CategoriesScreenRoutes>
    // MARK: - STATE PROPERTIES
    @State private var viewModel: ViewModel = ViewModel(articlesService: ArticlesServiceImpl())
    // MARK: - NAMESPACES
    @Namespace private var zoomTransition
    // MARK: - PROPERTIES
    let category: Category
    // MARK: - COMPUTED PROPERTIES
    private var filteredCategoryArticles: [ArticleModel] {
        var uniqueUrls = Set<String>()
        return viewModel.categoryArticles.filter {
            !$0.urlToImage.isEmpty && uniqueUrls.insert($0.url).inserted
        }
    }
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16.0) {
                ForEach(filteredCategoryArticles) { articleModel in
                    ArticleView(
                        articleModel: articleModel,
                        zoomTransition: zoomTransition,
                        onTap: { articleModel in
                            categoriesScreenRouter.navigate(
                                to: .articleDetails(articleModel: articleModel, zoomTransition: zoomTransition)
                            )
                        }
                    )
                }
                if viewModel.categoryArticles.count < viewModel.categoryArticlesTotalResult && viewModel.currentCategoryArticlesPage < 5 {
                    ProgressView()
                        .controlSize(.large)
                        .tint(.accent)
                        .onAppear {
                            if viewModel.errorMessage == nil {
                                viewModel.currentCategoryArticlesPage += 1
                            }
                            Task {
                                await getCategoryArticles()
                            }
                        }
                }
            }.padding(.horizontal, 16.0)
        }.navigationTitle("\(category.emoji) \(category.name)")
            .toolbarVisibility(.hidden, for: .tabBar)
            .task {
                if viewModel.categoryArticles.isEmpty {
                    await getCategoryArticles()
                }
            }
            .overlay(alignment: .bottom) {
                if let errorMessage = viewModel.errorMessage {
                    ErrorToastMessageView(
                        message: errorMessage
                    )
                }
            }
    }
    // MARK: - FUNCTIONS
    private func getCategoryArticles() async {
        let categoryName = category.name.lowercased()
        await viewModel.getCategoryArticles(category: categoryName)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        CategoryArticlesScreenView(
            category: Constants.categories.first!
        )
    }
}
