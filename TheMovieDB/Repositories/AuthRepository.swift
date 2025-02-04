//
//  AuthRepository.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 29/01/2025.
//

import Foundation

class AuthRepository {
    private let apiService: ApiService

    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }

    func requestToken() async throws -> String {
        let apiUrl = ApiUrls.requestToken
        print(apiUrl)
        let data = try await apiService.getRequest(url: apiUrl)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        guard let token = response.requestToken else { throw URLError(.badServerResponse) }
        return token
    }

    func validateLogin(username: String, password: String, requestToken: String) async throws -> Bool {
        let apiUrl = ApiUrls.validateLogin
        print(apiUrl)
        let body: [String: Any] = [
            "username": username,
            "password": password,
            "request_token": requestToken
        ]

        let requestBody = try? JSONSerialization.data(withJSONObject: body)
        let data = try await apiService.postRequest(url: apiUrl, body: requestBody)
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        return response.success
    }

    func createSession(requestToken: String) async throws -> String {
        let apiUrl = ApiUrls.createSession
        print(apiUrl)
        let body: [String: Any] = ["request_token": requestToken]
        let data = try await apiService.postRequest(url: apiUrl, body: try? JSONSerialization.data(withJSONObject: body, options: []))
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        guard let sessionId = response.sessionId else { throw URLError(.badServerResponse) }
        return sessionId
    }

    func getUserProfile(sessionId: String) async throws -> UserProfile {
        let apiUrl = ApiUrls.getUserProfile(sessionId: sessionId)
        print(apiUrl)
        let data = try await apiService.getRequest(url: apiUrl)
        return try JSONDecoder().decode(UserProfile.self, from: data)
    }
}
