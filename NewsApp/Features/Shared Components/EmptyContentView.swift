//
//  EmptyContentView.swift
//  NewsApp
//
//  Created by Dylan on 13/01/2025.
//

import SwiftUI

struct EmptyContentView: View {
    // MARK: - PROPERTIES
    let title: String
    let systemImage: String
    let description: String
    // MARK: - BODY
    var body: some View {
        ContentUnavailableView(
            title,
            systemImage: systemImage,
            description: Text(description)
        )
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    EmptyContentView(
        title: "Empty Content",
        systemImage: "tray.fill",
        description: "Your content will appear here."
    )
}
