//
//  CategorySelectionView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI

struct CategorySelectionView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - PROPERTIES
    let categories: [Category]
    @Binding var selectedCategory: Category
    
    // MARK: - COMPUTED PROPERTIES
    var itemForegroundColorByColorScheme: Color {
        colorScheme == .dark ? Color.white.opacity(0.75) : Color.black.opacity(0.75)
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8.0) {
                ForEach(categories) { category in
                    CategorySelectionItemView(
                        category: category,
                        backgroundColor: selectedCategory == category ? Color.accent : Color(uiColor: .tertiarySystemGroupedBackground),
                        foregroundColor: selectedCategory == category ? Color.white : itemForegroundColorByColorScheme,
                        onTap: {
                            selectedCategory = category
                        }
                    )
                    .animation(.spring, value: selectedCategory)
                }
            }.padding(.horizontal, 16.0)
        }
    }
}

struct CategorySelectionItemView: View {
    // MARK: - PROPERTIES
    let category: Category
    let backgroundColor: Color
    let foregroundColor: Color
    var onTap: (() -> Void)?
    
    // MARK: - BODY
    var body: some View {
        Text(category.name)
            .font(.subheadline)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
            .background(backgroundColor)
            .clipShape(.capsule)
            .contentShape(Capsule())
            .onTapGesture {
                onTap?()
            }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    CategorySelectionView(
        categories: Constants.categories,
        selectedCategory: .constant(Constants.categories.first!)
    )
}
