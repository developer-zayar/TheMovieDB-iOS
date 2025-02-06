//
//  LandscapeWebView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 06/02/2025.
//

import Foundation
import SwiftUI
import WebKit

struct LandscapeWebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> WebViewController {
        let viewController = WebViewController()
        viewController.url = url
        return viewController
    }

    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
        // No updates needed
    }
}

class WebViewController: UIViewController {
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = url {
            let webView = WKWebView()
            webView.load(URLRequest(url: url))
            webView.frame = view.bounds
            view.addSubview(webView)
        }
    }

    // Force landscape orientation
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    // Allow rotation to landscape
    override var shouldAutorotate: Bool {
        return true
    }
}
