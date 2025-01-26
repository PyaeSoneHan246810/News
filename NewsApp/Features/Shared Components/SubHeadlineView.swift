//
//  SubHeadlineView.swift
//  NewsApp
//
//  Created by Dylan on 02/01/2025.
//

import SwiftUI

struct SubHeadlineView: View {
    // MARK: - PROPERTIES
    let text: String
    
    // MARK: - BODY
    var body: some View {
        Text(text)
            .font(.subheadline)
            .opacity(0.75)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    SubHeadlineView(text: "Subheadline")
}
