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
                            ProgressView("Loading ...")
                                .padding()
                                .frame(maxHeight: .infinity)
                        } else if viewModel.userProfile != nil {
                            UserDetailsView(viewModel: viewModel)
                        } else {
                            ErrorView()
                        }

//                        Spacer()

//                        Button {
//                            showLogoutAlert = true
//                        } label: {
//                            Text("Logout")
//                                .font(.headline)
//                                .padding(10)
//                                .frame(maxWidth: .infinity)
//                                .foregroundStyle(Color.red)
//                        }
//                        .alert("Logout", isPresented: $showLogoutAlert) {
//                            Button("Cancel", role: .cancel) {}
//                            Button("Logout", role: .destructive) {
//                                viewModel.logout()
//                                dismiss()
//                            }
//                        } message: {
//                            Text("Are you sure you want to log out?")
//                        }
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
            .frame(maxHeight: .infinity, alignment: .top)
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
