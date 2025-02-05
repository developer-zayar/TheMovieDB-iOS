//
//  UserDetailsView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 05/02/2025.
//

import SwiftUI

struct UserDetailsView: View {
    let viewModel: AuthViewModel

    @Environment(\.dismiss) private var dismiss
    @State private var showLogoutAlert = false

    var body: some View {
        VStack {
            AsyncImage(url: ApiUrls.getImageURL(imagePath: viewModel.userProfile?.avatar?.tmdb?.avatarPath)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.tmdbSecondary, lineWidth: 2)
                    )
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white.opacity(0.8))
                            .frame(width: 40, height: 40)
                    )
            }

            Text("\(viewModel.userProfile?.username ?? "N/A")")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.tmdbPrimary)

            Text("\(viewModel.userProfile?.iso3166_1 ?? "") - \(viewModel.userProfile?.iso639_1 ?? "")")
                .font(.caption)
                .foregroundStyle(.secondary)

            // Uncomment when what to show name
//            Text("\(viewModel.userProfile?.name ?? "N/A")")
//                .font(.headline)
//                .fontWeight(.bold)
//                .foregroundStyle(.tmdbPrimary)

            List {
                Section {
                    NavigationLink(destination: FavoritesView()) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.tmdbSecondary)
                            Text("Favorites")
                        }
                    }

                    NavigationLink(destination: WatchlistView()) {
                        HStack {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(Color.tmdbSecondary)
                            Text("Watchlist")
                        }
                    }
                }
                .listRowBackground(Color.tmdbSecondary.opacity(0.1))

                Section {
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "power")
                                .foregroundColor(.red)
                            Text("Logout")
                                .foregroundColor(.red)
                        }
                    }
                    .alert("Logout", isPresented: $showLogoutAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Logout", role: .destructive) {
                            viewModel.logout()
                            dismiss()
                        }
                    } message: {
                        Text("Are you sure you want to log out?")
                    }
                }
                .listRowBackground(Color.tmdbSecondary.opacity(0.1))
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    UserDetailsView(viewModel: AuthViewModel())
}
