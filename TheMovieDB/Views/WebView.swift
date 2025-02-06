//
//  WebView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL?

    init(url: URL?) {
        self.url = url
    }

    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        return wkWebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else {
            print("WebView:Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

