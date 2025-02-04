//
//  ErrorView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 27/01/2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String?

    init(message: String? = "Something went wrong") {
        self.message = message
    }

    var body: some View {
        Text(message ?? "Unknown error occurred")
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView()
}
