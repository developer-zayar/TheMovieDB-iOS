//
//  APIService.swift
//  TheMovieDB
//
//  Created by Zay Yar Phyo on 23/01/2025.
//

import Foundation

class ApiService {
    private let session: URLSession
    private var accessToken: String? // Store the access token

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Update Access Token

    func updateAccessToken(_ token: String) {
        accessToken = token
    }

    // MARK: - GET Request

    func getRequest(url: String, headers: [String: String]? = nil) async throws -> Data {
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: requestURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.httpMethod = "GET"

        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.allHTTPHeaderFields = headers

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }

            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: request)

            return data

        } catch {
            print("Network request failed: \(error.localizedDescription)")

            if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
                print("Returning Cached Data Due to Network Error")
                return cachedResponse.data
            } else {
                throw URLError(.notConnectedToInternet) // No cache available, return error
            }
        }
    }

    // MARK: - POST Request

    func postRequest(url: String, headers: [String: String]? = nil, body: Data? = nil) async throws -> Data {
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.allHTTPHeaderFields = headers
        request.httpBody = body

        let (data, response) = try await session.data(for: request)

        print("Data:\n\(String(data: data, encoding: .utf8) ?? "No data")\nResponse:\n\(String(describing: response))\n")

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.badServerResponse(statusCode: 0, message: "Invalid server response")
        }

        print("StatusCode:\(httpResponse.statusCode)")
        switch httpResponse.statusCode {
            case 200 ... 299:
                // Success: Return the data
                return data
            case 401:
                // Unauthorized: Parse the error response
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    throw ApiError.unauthorized(statusCode: errorResponse.status_code, message: errorResponse.status_message ?? "Unauthorized")
                } else {
                    throw ApiError.unauthorized(statusCode: httpResponse.statusCode, message: "Unauthorized")
                }
            default:
                throw ApiError.badServerResponse(statusCode: httpResponse.statusCode, message: "Server returned an error")
        }

//        guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
//            throw URLError(.badServerResponse)
//        }
//
//        return data
    }

    // MARK: - PUT Request

    func putRequest(url: String, headers: [String: String]? = nil, body: Data? = nil) async throws -> Data {
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.allHTTPHeaderFields = headers
        request.httpBody = body

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return data
    }

    // MARK: - DELETE Request

    func deleteRequest(url: String, headers: [String: String]? = nil) async throws -> Data {
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        if let token = accessToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        request.allHTTPHeaderFields = headers

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}

enum ApiError: Error {
    case invalidURL
    case badServerResponse(statusCode: Int, message: String)
    case unauthorized(statusCode: Int, message: String)
    case other(Error)
}
