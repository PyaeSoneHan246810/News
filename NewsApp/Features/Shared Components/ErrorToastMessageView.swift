//
//  ErrorToastMessageView.swift
//  NewsApp
//
//  Created by Dylan on 13/01/2025.
//

import SwiftUI

struct ErrorToastMessageView: View {
    // MARK: - PROPERTIES
    let message: String
    // MARK: - BODY
    var body: some View {
        Text(message)
            .font(.caption)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 12.0)
            .foregroundStyle(
                Color.red.opacity(0.8)
            )
            .background(
                Color(uiColor: .systemGray6)
            )
            .clipShape(.rect(cornerRadius: 12.0))
            .transition(.scale)
            .padding(.horizontal, 12.0)
            .padding(.vertical, 16.0)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ErrorToastMessageView(message: "Something went wrong!")
}
