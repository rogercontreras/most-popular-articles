//
//  APIError.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 06/12/24.
//
import Foundation

enum APIError: Error, Equatable {
	case invalidUrl
		case invalidResponse
		case decodingError
		case networkError(URLError)
		case apiKeyInvalid
		case unknownError

	var errorDescription: String? {
		switch self {
			case .invalidUrl:
				return "The URL provided is invalid."
			case .invalidResponse:
				return "The server returned an invalid response."
			case .decodingError:
				return "The data received from the server could not be processed."
			case .networkError(let urlError):
				return urlError.localizedDescription
			case .apiKeyInvalid:
				return "The API key is invalid. Please verify your API key."
			case .unknownError:
				return "An unknown error occurred. Please try again later."
		}
	}
}
