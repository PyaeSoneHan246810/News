//
//  ArticleDetailsScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import SwiftData

struct ArticleDetailsScreenView: View {
    // MARK: - QUERIES
    @Query private var bookmarkArticleModels: [BookmarkArticleModel]
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // MARK: - STATE PROPERTIES
    @State private var isArticleWebViewPresented: Bool = false
    
    // MARK: - PROPERTIES
    let articleModel: ArticleModel
    let zoomTransition: Namespace.ID
    
    // MARK: - COMPUTED PROPERTIES
    private var isArticleBookmarked: Bool {
        return bookmarkArticleModels.contains(where: { $0.url == articleModel.url })
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20.0) {
                WebImageView(
                    urlString: articleModel.urlToImage
                ).frame(maxWidth: .infinity, minHeight: 240.0, maxHeight: 240.0)
                    .clipShape(.rect(cornerRadius: 20.0))
                Text(articleModel.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 8.0) {
                    HStack(spacing: 4.0) {
                        Text(articleModel.sourceName)
                        Text("•")
                        Text(articleModel.publishedAt)
                    }.font(.footnote)
                    HStack(spacing: 4.0) {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.accent)
                        Text(articleModel.author)
                            .font(.footnote)
                            .fontWeight(.medium)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Description")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(articleModel.desc)
                        .multilineTextAlignment(.leading)
                        .opacity(0.85)
                }.frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Content")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(articleModel.content)
                        .multilineTextAlignment(.leading)
                        .opacity(0.85)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.padding(16.0)
        }
        .fullScreenCover(isPresented: $isArticleWebViewPresented) {
            ArticleWebViewScreen(urlString: articleModel.url)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back", systemImage: "arrow.backward") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Read", systemImage: "link") {
                    isArticleWebViewPresented = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(
                    item: URL(string: articleModel.url)!
                ) {
                    Label(
                        "Share",
                        systemImage: "arrowshape.turn.up.right"
                    )
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Bookmark", systemImage: isArticleBookmarked ? "bookmark.fill" : "bookmark") {
                    addOrRemoveBookmark()
                }
            }
        }
        .toolbarVisibility(.hidden, for: .tabBar)
        .navigationTransition(.zoom(sourceID: articleModel, in: zoomTransition))
    }
    
    // MARK: - FUNCTIONS
    private func addOrRemoveBookmark() {
        if let bookmarkArticleModel = bookmarkArticleModels.first(where: { $0.url == articleModel.url}) {
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
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationStack {
        ArticleDetailsScreenView(
            articleModel: ArticleModel.previewArticleModels.first!,
            zoomTransition: Namespace().wrappedValue
        )
    }
}
