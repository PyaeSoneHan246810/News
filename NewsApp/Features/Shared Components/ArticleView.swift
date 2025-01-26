//
//  ArticleView.swift
//  NewsApp
//
//  Created by Dylan on 01/01/2025.
//

import SwiftUI

struct ArticleView: View {
    // MARK: - PROPERTIES
    let articleModel: ArticleModel
    let zoomTransition: Namespace.ID
    var onTap: ((ArticleModel) -> Void)?
    
    // MARK: - BODY
    var body: some View {
        HStack {
            WebImageView(
                urlString: articleModel.urlToImage
            ).frame(width: 112, height: 112)
                .clipShape(.rect(cornerRadius: 16.0))
                .matchedTransitionSource(id: articleModel, in: zoomTransition)
            VStack(alignment: .leading) {
                Text(articleModel.sourceName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .opacity(0.70)
                Text(articleModel.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(RoundedRectangle(cornerRadius: 16.0))
            .onTapGesture {
                onTap?(articleModel)
            }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ArticleView(
        articleModel: ArticleModel.previewArticleModels.first!,
        zoomTransition: Namespace().wrappedValue
    )
}
