//
//  BookmarksScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import SwiftData
import Routing

struct BookmarksScreenView: View {
    // MARK: - QUERIES
    @Query private var bookmarkArticleModels: [BookmarkArticleModel]
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - STATE OBJECTS PROPERTIES
    @StateObject private var bookmarksScreenRouter: Router<BookmarksScreenRoutes> = .init()
    
    // MARK: - NAMESPACE PROPERTIES
    @Namespace private var zoomTransition
    
    // MARK: - BODY
    var body: some View {
        RoutingView(stack: $bookmarksScreenRouter.stack) {
            if bookmarkArticleModels.isEmpty {
                EmptyContentView(
                    title: "No Bookmarks",
                    systemImage: "bookmark.fill",
                    description: "Your bookmarks will appear here."
                )
                .navigationTitle("Bookmarks")
            } else {
                List {
                    SubHeadlineView(text: "Saved articles to the library")
                        .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .listRowBackground(Color.clear)
                    ForEach(bookmarkArticleModels) { bookmarkArticleModel in
                        let articleModel = ArticleModel.fromBookmarkArticleModel(bookmarkArticleModel)
                        ArticleView(
                            articleModel: articleModel,
                            zoomTransition: zoomTransition,
                            onTap: { articleModel in
                                bookmarksScreenRouter.navigate(
                                    to: .articleDetails(articleModel: articleModel, zoomTransition: zoomTransition)
                                )
                            }
                        )
                        .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 16.0)
                                .fill(Color.clear)
                        )
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let bookmarkArticleModel = bookmarkArticleModels[index]
                            removeBookmark(bookmarkArticleModel)
                        }
                    }
                }
                .listRowSpacing(12.0)
                .listRowSeparator(.hidden)
                .scrollContentBackground(.hidden)
                .navigationTitle("Bookmarks")
            }
        }
    }
    
    // MARK: - FUNCTIONS
    private func removeBookmark(_ bookmarkArticleModel: BookmarkArticleModel) {
        modelContext.delete(bookmarkArticleModel)
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    BookmarksScreenView()
}
