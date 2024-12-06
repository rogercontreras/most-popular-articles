//
//  NYTApiService.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//
import Foundation

protocol NYTApiServiceProtocol {
	func getMostPopularArticles(period: PeriodType, service: ServiceType, useCacheOnly: Bool) async throws -> [Article]
}

class NYTApiService: NYTApiServiceProtocol {
	
	private let baseUrl: String = "https://api.nytimes.com/svc/mostpopular/v2/"
	private let apiKey: String = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
	private let session: URLSessionProtocol
	
	init(session: URLSessionProtocol = URLSession.shared) {
		self.session = session
	}
	
	func getMostPopularArticles(period: PeriodType = .day, service: ServiceType = .viewed, useCacheOnly: Bool = false) async throws -> [Article] {
		
		guard let url = URL(string: baseUrl + "\(service.rawValue)/\(period.rawValue).json?api-key=\(apiKey)") else {
			throw APIError.invalidUrl
		}
		
		let request = URLRequest(url: url,
								 cachePolicy: useCacheOnly ? .returnCacheDataDontLoad : .useProtocolCachePolicy,
								  timeoutInterval: 10.0)
		
		let (data, response) = try await session.data(for: request)
		
		guard let httpResponse = response as? HTTPURLResponse else {
			throw APIError.invalidResponse
		}
		
		
		
		guard (200...299).contains(httpResponse.statusCode) else {
			switch httpResponse.statusCode {
				case 400: throw APIError.networkError(URLError(.badURL))
				case 401: throw APIError.apiKeyInvalid
				default:throw APIError.networkError(URLError(URLError.Code(rawValue: httpResponse.statusCode)))
			}
		}
		
		do {
			let result = try JSONDecoder().decode(MostPopularResponse.self, from: data)
			return result.results
		} catch {
			throw APIError.decodingError
		}
	}
}






