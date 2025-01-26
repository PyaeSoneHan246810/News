//
//  MainApp.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import SwiftData

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView()
        }.modelContainer(for: BookmarkArticleModel.self)
    }
}
