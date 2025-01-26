//
//  CategoryItemView.swift
//  NewsApp
//
//  Created by Dylan on 02/01/2025.
//

import SwiftUI

struct CategoryItemView: View {
    // MARK: - PROPERTIES
    let category: Category
    var onTap: (() -> Void)?
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12.0) {
            Text(category.emoji)
                .font(.system(size: 26.0))
            Text(category.name)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, minHeight: 100.0)
        .clipShape(.rect(cornerRadius: 16.0))
        .overlay {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(Color.clear)
                .stroke(Color(uiColor: .tertiarySystemGroupedBackground), lineWidth: 1.0)
        }
        .contentShape(
            RoundedRectangle(cornerRadius: 16.0)
        )
        .onTapGesture {
            onTap?()
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    CategoryItemView(category: Constants.categories.first!)
}
