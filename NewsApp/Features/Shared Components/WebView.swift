//
//  WebView.swift
//  NewsApp
//
//  Created by Dylan on 02/01/2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        wkWebView.load(urlRequest)
    }
}
