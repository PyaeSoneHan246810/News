//
//  HomeScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import SwiftData
import Routing

struct HomeScreenView: View {
    // MARK: - QUERIES
    @Query private var bookmarkArticleModels: [BookmarkArticleModel]
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - STATE OBJECT PROPERTIES
    @StateObject private var homeScreenRouter: Router<HomeScreenRoutes> = .init()
    
    // MARK: - NAMESPACE PROPERTIES
    @Namespace private var topHeadlineZoomTransition
    @Namespace private var recommendationZoomTransition
    
    // MARK: - STATE PROPERTIES
    @State private var viewModel: ViewModel = ViewModel(articlesService: ArticlesServiceImpl())
    
    // MARK: - APP STORAGE PROPERTIES
    @AppStorage("selectCategory") private var selectedCategory: Category = Constants.categories.first!
    
    // MARK: - COMPUTED PROPERTIES
    private var selectedCategoryName: String {
        selectedCategory.name.lowercased()
    }
    
    // MARK: - BODY
    var body: some View {
        RoutingView(stack: $homeScreenRouter.stack) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20.0) {
                    SubHeadlineView(text: "Discover things of this world")
                        .padding(.horizontal, 16.0)
                    SearchBoxView(
                        onTap: {
                            homeScreenRouter.navigate(to: .search)
                        }
                    )
                    CategorySelectionView(
                        categories: Constants.categories,
                        selectedCategory: $selectedCategory
                    )
                    topHeadlineArticlesView()
                    VStack(spacing: 12.0) {
                        recommendedArticlesHeaderView()
                        recommendedArticlesView()
                    }
                }
            }
            .navigationTitle("Browse")
        }
        .task {
            if case .loading = viewModel.topHeadlineArticlesState {
                await viewModel.getTopHeadlineArticles(category: selectedCategoryName)
            }
        }
        .task {
            if case .loading = viewModel.recommendedArticlesState {
                await viewModel.getRecommendedArticles()
            }
        }
        .onChange(of: selectedCategory) {
            Task {
                await viewModel.getTopHeadlineArticles(category: selectedCategoryName)
            }
        }
        .environmentObject(homeScreenRouter)
    }
    
    // MARK: - SUB VIEWS
    @ViewBuilder
    private func topHeadlineArticlesView() -> some View {
        switch viewModel.topHeadlineArticlesState {
        case .loading:
            LoadingProgressView()
        case .loaded(let topHeadlineArticles):
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16.0) {
                    ForEach(filterUniqueArticles(topHeadlineArticles)) { articleModel in
                        TopHeadlineArticleItemView(
                            articleModel: articleModel,
                            zoomTransition: topHeadlineZoomTransition,
                            onTap: { articleModel in
                                homeScreenRouter.navigate(
                                    to: .articleDetails(
                                        articleModel: articleModel,
                                        zoomTransition: topHeadlineZoomTransition
                                    )
                                )
                            },
                            onBookmarkButtonTap: { articleModel in
                                addOrRemoveBookmark(articleModel)
                            }
                        )
                    }
                }.padding(.horizontal, 16.0)
            }
        case .error(let networkingError):
            ErrorContentView(
                errorMessage: networkingError.localizedDescription,
                onRetryButtonClicked: {
                    Task {
                        await viewModel.getTopHeadlineArticles(category: selectedCategoryName)
                    }
                }
            )
        }
    }
    
    @ViewBuilder
    private func recommendedArticlesHeaderView() -> some View {
        HStack {
            Text("Recommended for you")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Button {
                viewModel.recommendation = Constants.recommendedQueries.randomElement()!
                Task {
                    await viewModel.getRecommendedArticles()
                }
            } label: {
                Text("Refresh")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }.padding(.horizontal, 16.0)
    }
    
    @ViewBuilder
    private func recommendedArticlesView() -> some View {
        switch viewModel.recommendedArticlesState {
        case .loading:
            LoadingProgressView()
        case .loaded(let recommendedArticles):
            LazyVStack(spacing: 16.0) {
                ForEach(filterUniqueArticles(recommendedArticles)) { articleModel in
                    ArticleView(
                        articleModel: articleModel,
                        zoomTransition: recommendationZoomTransition,
                        onTap: { articleModel in
                            homeScreenRouter.navigate(
                                to: .articleDetails(
                                    articleModel: articleModel,
                                    zoomTransition: recommendationZoomTransition
                                )
                            )
                        }
                    )
                }
            }.padding(.horizontal, 16.0)
        case .error(let networkingError):
            ErrorContentView(
                errorMessage: networkingError.localizedDescription,
                onRetryButtonClicked: {
                    Task {
                        await viewModel.getRecommendedArticles()
                    }
                }
            )
        }
    }
    
    // MARK: - FUNCTIONS
    private func addOrRemoveBookmark(_ articleModel: ArticleModel) {
        let bookmarkArticleModel = bookmarkArticleModels.first(where: { $0.url == articleModel.url})
        if let bookmarkArticleModel {
            modelContext.delete(bookmarkArticleModel)
        } else {
            modelContext.insert(articleModel.toBookmarkArticleModel())
        }
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func filterUniqueArticles(_ articles: [ArticleModel]) -> [ArticleModel] {
        var uniqueUrls = Set<String>()
        return articles.filter {
            !$0.urlToImage.isEmpty && uniqueUrls.insert($0.url).inserted
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    HomeScreenView()
}
