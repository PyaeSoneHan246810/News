//
//  ErrorContentView.swift
//  NewsApp
//
//  Created by Dylan on 13/01/2025.
//

import SwiftUI

struct ErrorContentView: View {
    // MARK: - PROPERTIES
    let errorMessage: String
    var onRetryButtonClicked: (() -> Void)?
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text(errorMessage)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Button("Retry") {
                    onRetryButtonClicked?()
                }.buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
            }
        }.padding(20.0)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ErrorContentView(errorMessage: "Internet connection lost.")
}
