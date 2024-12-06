//
//  NYTApiServiceMock.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 06/12/24.
//

class NYTApiServiceMock: NYTApiServiceProtocol {
	
	var result: Result<[Article], Error> = .success([])
	
	func getMostPopularArticles(period: PeriodType, service: ServiceType, useCacheOnly: Bool = false) async throws -> [Article] {
	 switch result {
	 case .success(let articles):
		 return articles
	 case .failure(let error):
		 throw error
	 }
 }
}
