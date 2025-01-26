//
//  MainContentView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

struct MainContentView: View {
    // MARK: - PROPERTIES
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    // MARK: - BODY
    var body: some View {
        TabsScreenView()
            .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
    }
}

#Preview {
    MainContentView()
        .modelContainer(for: BookmarkArticleModel.self, inMemory: true)
}
