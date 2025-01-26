//
//  WebImageView.swift
//  NewsApp
//
//  Created by Dylan on 01/01/2025.
//

import SwiftUI
import Kingfisher

struct WebImageView: View {
    // MARK: - PROPERTIES
    let urlString: String
    
    // MARK: - BODY
    var body: some View {
        KFImage(URL(string: urlString))
            .cacheMemoryOnly()
            .fade(duration: 0.5)
            .placeholder {
                Rectangle()
                    .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                    .overlay {
                        ProgressView()
                            .controlSize(.large)
                    }
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}
