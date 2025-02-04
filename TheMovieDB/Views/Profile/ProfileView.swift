//
//  ProfileView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 27/01/2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: AuthViewModel = .init()

    @Environment(\.dismiss) private var dismiss

    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                Image(.logoLongText)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 64)
                    .padding()

                if viewModel.isLoggedIn {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView("Loading ...").padding()
                        } else if viewModel.errorMessage != nil {
                            ErrorView(message: viewModel.errorMessage)
                        } else {
                            AsyncImage(url: ApiUrls.getImageURL(imagePath: viewModel.userProfile?.avatar?.tmdb?.avatarPath)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
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
                        }

                        Spacer()

                        Button {
                            showLogoutAlert = true
                        } label: {
                            Text("Logout")
                                .font(.headline)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.red)
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
                    .onAppear {
                        Task {
                            await viewModel.getUserProfile()
                        }
                    }

                } else {
                    LoginView(viewModel: viewModel)
//                    Text("Login required")
                }
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

#Preview {
    ProfileView()
}
