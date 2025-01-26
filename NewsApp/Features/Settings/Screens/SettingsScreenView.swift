//
//  ProfileScreenView.swift
//  NewsApp
//
//  Created by Dylan on 31/12/2024.
//

import SwiftUI
import Routing

struct SettingsScreenView: View {
    // MARK: - STATE OBJECT PROPERTIES
    @StateObject private var settingsScreenRouter: Router<SettingsScreenRoutes> = .init()
    
    // MARK: - APP STORAGE PROPERTIES
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    
    // MARK: - BODY
    var body: some View {
        RoutingView(stack: $settingsScreenRouter.stack) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20.0) {
                    GroupBox {
                        HStack {
                            Text("Dark Mode")
                            Spacer()
                            Toggle("Enabled", isOn: $isDarkModeEnabled)
                                .tint(.accent)
                                .labelsHidden()
                        }
                    }
                }.padding(16.0)
            }.navigationTitle("Settings")
        }
    }
}

// MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    SettingsScreenView()
}
