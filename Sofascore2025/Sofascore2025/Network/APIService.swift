//
//  APIService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 28.04.2025..
//

import Foundation

enum APIService {

    static func fetchEvents(for sportType: SportType) async throws -> [Event]? {
        do {
            let apiEvents: [APIEvent] = try await APIClient.getEvents(for: sportType)
            DatabaseService.saveEventsData(apiEvents, sportType)
            return DatabaseService.readEvents(for: sportType)
        } catch let error as APIError {
            switch error {
            case .noInternet:
                throw APIErrorWithDetails.custom(
                    title: APIError.noInternet.title,
                    message: APIError.noInternet.message,
                    type: .noInternet
                )

            case .invalidURL:
                throw APIErrorWithDetails.custom(
                    title: APIError.invalidURL.title,
                    message: APIError.invalidURL.message,
                    type: .invalidURL
                )

            case .decodingFailed:
                throw APIErrorWithDetails.custom(
                    title: APIError.decodingFailed.title,
                    message: APIError.decodingFailed.message,
                    type: .decodingFailed
                )

            case .unknown(let error):
                throw APIErrorWithDetails.custom(
                    title: APIError.unknown(error).title,
                    message: APIError.unknown(error).message,
                    type: .unknown(error)
                )

            case .unauthorized:
                throw APIErrorWithDetails.custom(
                    title: APIError.unauthorized.title,
                    message: APIError.unauthorized.message,
                    type: .unauthorized
                )

            case .invalidResponse:
                throw APIErrorWithDetails.custom(
                    title: APIError.invalidResponse.title,
                    message: APIError.invalidResponse.message,
                    type: .invalidResponse
                )

            case .serverError(let statusCode):
                throw APIErrorWithDetails.custom(
                    title: APIError.serverError(statusCode).title,
                    message: APIError.serverError(statusCode).message,
                    type: .serverError(statusCode)
                )

            case .validationFailed:
                throw APIErrorWithDetails.custom(
                    title: APIError.validationFailed.title,
                    message: APIError.validationFailed.message,
                    type: .validationFailed
                )
            }
        }
    }

    static func login(username: String?, password: String?) async throws -> APIAuthResponse? {
        let validatedUsername: String
        let validatedPassword: String

        do {
            (validatedUsername, validatedPassword) = try AuthCredentialsValidatorService.validate(username, password)
        } catch {
            if let credentialError = error as? AuthCredentialsError {
                throw APIErrorWithDetails.custom(
                    title: credentialError.title,
                    message: credentialError.message,
                    type: .validationFailed
                )
            }
            throw error
        }

        do {
            let response = try await APIClient.login(username: validatedUsername, password: validatedPassword)
            return response
        } catch let error as APIError {
            switch error {
            case .noInternet:
                throw APIErrorWithDetails.custom(
                    title: APIError.noInternet.title,
                    message: APIError.noInternet.message,
                    type: .noInternet
                )

            case .invalidURL:
                throw APIErrorWithDetails.custom(
                    title: APIError.invalidURL.title,
                    message: APIError.invalidURL.message,
                    type: .invalidURL
                )

            case .decodingFailed:
                throw APIErrorWithDetails.custom(
                    title: APIError.decodingFailed.title,
                    message: APIError.decodingFailed.message,
                    type: .decodingFailed
                )

            case .unauthorized:
                throw APIErrorWithDetails.custom(
                    title: .unauthorizedLoginErrorTitle,
                    message: .unauthorizedLoginErrorMessage,
                    type: .unauthorized
                )

            case .unknown(let error):
                throw APIErrorWithDetails.custom(
                    title: APIError.unknown(error).title,
                    message: APIError.unknown(error).message,
                    type: .unknown(error)
                )

            default:
                break
            }
            return nil
        }
    }
}
