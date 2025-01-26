//
//  CategoriesScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

struct CategoriesScreenView: View {
    // MARK: - STATE OBJECT PROPERTIES
    @StateObject private var categoriesScreenRouter: Router<CategoriesScreenRoutes> = .init()
    // MARK: - PROPERTIES
    let categoryGridColumns: [GridItem] = [
        GridItem(.adaptive(minimum: 140.0), spacing: 16.0)
    ]
    // MARK: - BODY
    var body: some View {
        RoutingView(stack: $categoriesScreenRouter.stack) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20.0) {
                    SubHeadlineView(text: "Thousands of articles in each category")
                        .padding(.horizontal, 16.0)
                    LazyVGrid(
                        columns: categoryGridColumns,
                        spacing: 16.0
                    ) {
                        ForEach(Constants.categories) { category in
                            CategoryItemView(
                                category: category,
                                onTap: {
                                    categoriesScreenRouter.navigate(
                                        to: .categoryArticles(category: category)
                                    )
                                }
                            )
                        }
                    }.padding(.horizontal, 16.0)
                }
            }
            .navigationTitle("Categories")
        }.environmentObject(categoriesScreenRouter)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    CategoriesScreenView()
}
