//
//  MostPopularViewModelTests.swift
//  Most Popular ArticlesTests
//
//  Created by Rogelio Contreras on 06/12/24.
//

import XCTest
@testable import Most_Popular_Articles

@MainActor
final class MostPopularViewModelTests: XCTestCase {
	private var viewModel: MostPopularViewModel!
	private var apiServiceMock: NYTApiServiceMock!
	
	override func setUp() {
		super.setUp()
		apiServiceMock = NYTApiServiceMock()
		viewModel = MostPopularViewModel(apiService: apiServiceMock)
	}

	override func tearDown() {
		viewModel = nil
		apiServiceMock = nil
		super.tearDown()
	}
	
    func testFetchMostPopularArticles_Success() async {
		let articles = [
			Article(id: 1, title: "Lorem Ipsum", summary: "Lorem Ipsum dolor sit amet", byline: "by John Doe", url: "https://nyt.com/1", publishedDate: "2024-12-06", section: "Opinion", media: []),
			Article(id: 2, title: "Lorem Ipsum", summary: "Lorem Ipsum dolor sit amet", byline: "by John Doe", url: "https://nyt.com/2", publishedDate: "2024-12-06", section: "Opinion", media: []),
			Article(id: 3, title: "Lorem Ipsum", summary: "Lorem Ipsum dolor sit amet", byline: "by John Doe", url: "https://nyt.com/3", publishedDate: "2024-12-06", section: "Opinion", media: [])
		]
		apiServiceMock.result = .success(articles)
		
		await viewModel.fetchMostPopularArticles()

		XCTAssertEqual(viewModel.articles, articles)
		XCTAssertNil(viewModel.error)
	}
	
	func testFetchMostPopularArticles_Failure() async {
		apiServiceMock.result = .failure(APIError.decodingError)
		
		await viewModel.fetchMostPopularArticles()
		
		XCTAssertTrue(viewModel.articles.isEmpty)
		XCTAssertEqual(viewModel.error, APIError.decodingError.errorDescription)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
