//
//  MoviePlayerView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

import SwiftUI

struct MoviePlayerView: View {
    let urlString: String

    var body: some View {
        VStack {
            WebView(url: URL(string: urlString)!)
        }
    }
}

#Preview {
    MoviePlayerView(urlString: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")
}
