//
//  TabsScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

struct TabsScreenView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeScreenView()
            }
            Tab("Categories", systemImage: "square.grid.2x2") {
                CategoriesScreenView()
            }
            Tab("Bookmarks", systemImage: "bookmark") {
                BookmarksScreenView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreenView()
            }
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    TabsScreenView()
}
