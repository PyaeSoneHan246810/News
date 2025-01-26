//
//  TopHeadlineArticleItemView.swift
//  NewsApp
//
//  Created by Dylan on 01/01/2025.
//

import SwiftUI
import SwiftData

struct TopHeadlineArticleItemView: View {
    // MARK: - QUERIES
    @Query private var bookmarkArticleModels: [BookmarkArticleModel]
    
    // MARK: - PROPERTIES
    let articleModel: ArticleModel
    let zoomTransition: Namespace.ID
    var onTap: ((ArticleModel) -> Void)?
    var onBookmarkButtonTap: ((ArticleModel) -> Void)?
    
    // MARK: - COMPUTED PROPERTIES
    private var isArticleBookmarked: Bool {
        return bookmarkArticleModels.contains(where: { $0.url == articleModel.url })
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            WebImageView(
                urlString: articleModel.urlToImage
            )
            .overlay {
                Rectangle()
                    .fill(.black.opacity(0.25))
            }
        }
        .frame(width: 300.0, height: 300.0)
        .matchedTransitionSource(id: articleModel, in: zoomTransition)
        .overlay(alignment: .topTrailing) {
            Button {
                onBookmarkButtonTap?(articleModel)
            } label: {
                Image(systemName: isArticleBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.title)
                    .foregroundStyle(.white)
            }.buttonStyle(.plain)
                .padding(16.0)
        }
        .overlay(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4.0) {
                Group {
                    Text(articleModel.sourceName)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .opacity(0.75)
                    Text(articleModel.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                }.foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
            }.padding(16.0)
        }
        .clipShape(.rect(cornerRadius: 20.0))
        .contentShape(RoundedRectangle(cornerRadius: 20.0))
        .onTapGesture {
            onTap?(articleModel)
        }
    }

}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    TopHeadlineArticleItemView(
        articleModel: ArticleModel.previewArticleModels.first!,
        zoomTransition: Namespace().wrappedValue
    )
}
