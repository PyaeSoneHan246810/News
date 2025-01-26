//
//  SearchScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

struct SearchScreenView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @EnvironmentObject private var homeScreenRouter: Router<HomeScreenRoutes>
    // MARK: - STATE PROPERTIES
    @State private var viewModel: ViewModel = ViewModel(
        articlesService: ArticlesServiceImpl()
    )
    @State private var showErrorToastMessage: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    // MARK: - NAMESPACES
    @Namespace private var zoomTransition
    // MARK: - COMPUTED PROPERTIES
    private var filteredSearchArticles: [ArticleModel] {
        var uniqueUrls = Set<String>()
        return viewModel.searchArticles.filter {
            !$0.urlToImage.isEmpty && uniqueUrls.insert($0.url).inserted
        }
    }
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 12.0) {
            TextField("Search for articles", text: $viewModel.searchQuery)
                .focused($isTextFieldFocused)
                .textInputAutocapitalization(.never)
                .padding(.horizontal)
                .frame(height: 56.0)
                .background(
                    isTextFieldFocused ? Color.accent.opacity(0.5) : Color(uiColor: .secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12.0).stroke(lineWidth: 2.0)
                )
                .overlay(alignment: .trailing) {
                    if !viewModel.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Button {
                            viewModel.searchQuery = ""
                            viewModel.resetSearchArticlesStates()
                        } label: {
                            Image(systemName: "xmark")
                        }.padding()
                    }
                }
                .padding(.horizontal, 16.0)
                .onSubmit {
                    viewModel.resetSearchArticlesStates()
                    Task {
                        await viewModel.searchArticles()
                    }
                }
            if viewModel.searchState == .idle {
                EmptyContentView(
                    title: "Search For Articles",
                    systemImage: "magnifyingglass",
                    description: "Type in your search query to start searching for articles."
                )
            } else if filteredSearchArticles.isEmpty && viewModel.searchState != .failed {
                EmptyContentView(
                    title: "No Articles Found",
                    systemImage: "document.fill",
                    description: "Couldn't find any articles matching your search query."
                )
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 16.0) {
                        ForEach(filteredSearchArticles) { articleModel in
                            ArticleView(
                                articleModel: articleModel,
                                zoomTransition: zoomTransition,
                                onTap: { articleModel in
                                    homeScreenRouter.navigate(
                                        to: .articleDetails(
                                            articleModel: articleModel,
                                            zoomTransition: zoomTransition
                                        )
                                    )
                                }
                            )
                        }
                        if viewModel.searchArticles.count < viewModel.searchArticlesTotalResult && viewModel.currentSearchArticlesPage < 5 {
                            ProgressView()
                                .controlSize(.large)
                                .tint(.accent)
                                .onAppear {
                                    if viewModel.searchState != .failed {
                                        viewModel.currentSearchArticlesPage += 1
                                    }
                                    Task {
                                        await viewModel.searchArticles()
                                    }
                                }
                        }
                    }.padding(.horizontal, 16.0)
                        .padding(.vertical, 12.0)
                }
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(.hidden, for: .tabBar)
        .onChange(of: viewModel.searchState) {
            withAnimation(.smooth) {
                if viewModel.searchState == .failed {
                    showErrorToastMessage = true
                } else {
                    showErrorToastMessage = false
                }
            }
        }
        .overlay(alignment: .bottom) {
            if showErrorToastMessage {
                ErrorToastMessageView(
                    message: viewModel.errorMessage ?? "Something went wrong!"
                )
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    SearchScreenView()
}
