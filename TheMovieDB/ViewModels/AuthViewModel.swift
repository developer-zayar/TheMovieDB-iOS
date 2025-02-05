//
//  AuthViewModel.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 24/01/2025.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var sessionId: String?
    @Published var userProfile: UserProfile?

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false

    private let appStorageManager = AppStorageManager()
    private let authRepository: AuthRepository

    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
        self.sessionId = appStorageManager.getString(forKey: UserDefaultKeys.userSessionId)
        self.isLoggedIn = sessionId != nil
    }

    func login(username: String, password: String) async {
        isLoading = true
        do {
            // a delay for loading animation
            try await Task.sleep(for: .seconds(2))

            // Get request token
            let requestToken = try await authRepository.requestToken()

            // Validate user credentials
            let isValidUser = try await authRepository.validateLogin(username: username, password: password, requestToken: requestToken)
            guard isValidUser else {
                errorMessage = "Invalid credentials"
                showAlert = true
                return
            }

            // Create session
            sessionId = try await authRepository.createSession(requestToken: requestToken)
            if let sessionId {
                appStorageManager.saveString(sessionId, forKey: UserDefaultKeys.userSessionId)
                isLoggedIn = true
            }
        } catch let ApiError.unauthorized(_, message) {
            errorMessage = "Login failed: \(message)"
            showAlert = true
        } catch let ApiError.badServerResponse(_, message) {
            errorMessage = "Server error: \(message)"
            showAlert = true
        } catch {
            errorMessage = "Login failed: \(error.localizedDescription)"
            showAlert = true
        }

        isLoading = false
    }

    func getUserProfile() async {
        guard let sessionId = sessionId else {
            isLoggedIn = false
            errorMessage = "Please login to see user profile!"
            return
        }

        guard userProfile == nil else {
            return
        }

        isLoading = true

        do {
            userProfile = try await authRepository.getUserProfile(sessionId: sessionId)
        } catch {
            errorMessage = "Failed to fetch user profile: \(error.localizedDescription)"
            showAlert = true
        }

        isLoading = false
    }

    func logout() {
        isLoggedIn = false
        sessionId = nil
        userProfile = nil
        appStorageManager.removeObject(forKey: UserDefaultKeys.userSessionId)
    }
}
