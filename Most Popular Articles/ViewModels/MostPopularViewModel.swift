//
//  MostPopularViewModel.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//
import Foundation
import Network

@MainActor
class MostPopularViewModel: ObservableObject {
	@Published var articles: [Article] = []
	@Published var selectedArticle: Article?
	@Published var error: String?
	@Published var currentService: ServiceType = .viewed
	@Published var selectedPeriod: PeriodType = .day
	@Published var useCacheOnly: Bool = false
	
	private let apiService: NYTApiServiceProtocol
	private let monitor: NWPathMonitor
	
	init(apiService: NYTApiServiceProtocol = NYTApiService(), monitor : NWPathMonitor = NWPathMonitor()) {
		self.apiService = apiService
		self.monitor = monitor
		self.monitor.pathUpdateHandler = { path in
			Task { @MainActor in
				self.useCacheOnly = (path.status != .satisfied)
			}
		}
		monitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
	}

	func fetchMostPopularArticles() async {
		do {
			let fetchedArticles = try await apiService.getMostPopularArticles(period: selectedPeriod, service: currentService, useCacheOnly: useCacheOnly)
			self.articles = fetchedArticles
		} catch let apiError as APIError {
			self.error = apiError.errorDescription
		} catch {
			self.error = error.localizedDescription
		}
	}
}
