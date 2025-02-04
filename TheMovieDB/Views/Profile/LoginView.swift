//
//  LoginView.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 01/02/2025.
//

import SwiftUI

struct LoginView: View {
    let viewModel: AuthViewModel
    @State private var username: String = ""
    @State private var password: String = ""

    @Environment(\.openURL) var openURL

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
//                Text("TheMovieDB Login")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)

                TextField("Username", text: $username)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(12)
                    .foregroundStyle(.tmdbPrimary)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .textFieldStyle(.plain)
                    .padding(12)
                    .foregroundStyle(.tmdbPrimary)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                ProgressButton(
                    title: "Login",
                    loadingText: "Logging in ...",
                    isDisabled: username.isEmpty || password.isEmpty
                ) {
                    await viewModel.login(username: username, password: password)
                }

                Text("Don't you have account?")
                    .font(.headline)
                    .padding(.top)
                
                Link("Sign Up Here", destination: AppUtils.tmdbSignupUrl!)
                    .font(.headline)
                    .foregroundStyle(.tmdbSecondary)

//                Button("Sign Up Here") {
//                    openURL(AppUtils.tmdbSignupUrl!)
//                }
//                .padding()

//                if let errorMessage = viewModel.errorMessage {
//                    ErrorView(message: errorMessage)
//                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView(viewModel: AuthViewModel())
}
