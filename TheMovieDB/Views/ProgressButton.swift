//
//  ProgressButton.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 04/02/2025.
//

import SwiftUI

struct ProgressButton: View {
    var title: String
    var loadingText: String?
    var isDisabled: Bool = false
    var action: () async -> Void

    @State var isLoading: Bool = false

    var body: some View {
        Button {
            Task {
                isLoading = true
                await action()
                isLoading = false
            }
        } label: {
            HStack {
                if isLoading {
                    HStack {
                        ProgressView()
                            .tint(.white)

                        if loadingText != nil {
                            Text(loadingText?.isEmpty ?? true ? "Loading ..." : loadingText!)
                                .font(.headline)
                        }
                    }
                } else {
                    Text(title)
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.tmdbSecondary)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .disabled(isDisabled || isLoading)
        .padding(.horizontal)
    }
}

#Preview {
    ProgressButton(title: "Login", action: {})
}
