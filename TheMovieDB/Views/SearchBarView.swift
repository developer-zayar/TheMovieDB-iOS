//
//  SearchBarView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 29/01/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search...", text: $searchText)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
