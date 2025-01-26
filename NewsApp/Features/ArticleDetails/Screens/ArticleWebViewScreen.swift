//
//  ArticleWebViewScreen.swift
//  NewsApp
//
//  Created by Dylan on 02/01/2025.
//

import SwiftUI

struct ArticleWebViewScreen: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - PROPERTIES
    let urlString: String
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            WebView(
                urlString: urlString
            ).ignoresSafeArea()
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Back", systemImage: "arrow.backward") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ArticleWebViewScreen(
        urlString: ArticleModel.previewArticleModels.first!.url
    )
}
