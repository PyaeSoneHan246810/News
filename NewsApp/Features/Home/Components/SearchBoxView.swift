//
//  SearchBoxView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI

struct SearchBoxView: View {
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - PROPERTIES
    var onTap: (() -> Void)?
    
    // MARK: - COMPUTED PROPERTIES
    private var foregroundColorByColorScheme: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    // MARK: - BODY
    var body: some View {
        GroupBox {
            HStack {
                HStack(spacing: 16.0) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                        .foregroundStyle(foregroundColorByColorScheme)
                    Text("Search")
                        .font(.headline)
                        .foregroundStyle(foregroundColorByColorScheme)
                        .opacity(0.75)
                }
                Spacer()
            }
        }.padding(.horizontal, 16.0)
            .clipShape(.rect(cornerRadius: 16.0))
            .contentShape(RoundedRectangle(cornerRadius: 16.0))
            .onTapGesture {
                onTap?()
            }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    SearchBoxView()
}
