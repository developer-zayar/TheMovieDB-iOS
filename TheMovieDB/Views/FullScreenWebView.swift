//
//  FullScreenWebView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 06/02/2025.
//

import SwiftUI

struct FullScreenWebView: View {
    let movieId: Int
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        LandscapeWebView(url: ApiUrls.watchMovieURL(movieId: movieId)!)
            .edgesIgnoringSafeArea(.all) // Make the WebView full screen
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
    }
}

#Preview {
    FullScreenWebView(movieId: 299536)
}
