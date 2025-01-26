//
//  LoadingProgressView.swift
//  NewsApp
//
//  Created by Dylan on 13/01/2025.
//

import SwiftUI

struct LoadingProgressView: View {
    // MARK: - PROPERTIES
    // MARK: - BODY
    var body: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.accent)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    LoadingProgressView()
}
