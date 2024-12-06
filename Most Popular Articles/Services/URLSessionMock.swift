//
//  URLSessionMock.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 06/12/24.
//
import Foundation

protocol URLSessionProtocol {
	func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

class URLSessionMock: URLSessionProtocol, @unchecked Sendable {
	private let data: Data?
	private let response: URLResponse?
	private let error: Error?
	
	init(mockData: Data?, mockResponse: URLResponse?, mockError: Error?) {
		self.data = mockData
		self.response = mockResponse
		self.error = mockError
	}
	
	func data(for url: URLRequest) async throws -> (Data, URLResponse) {
		if let error {
			throw error
		}
		
		guard let data, let response else {
			throw URLError(.badServerResponse)
		}
		
		return (data, response)
	}
	
}

extension URLSession: URLSessionProtocol {}
