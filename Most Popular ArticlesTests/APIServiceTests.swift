//
//  APIServiceTests.swift
//  Most Popular ArticlesTests
//
//  Created by Rogelio Contreras on 06/12/24.
//
import XCTest
@testable import Most_Popular_Articles

final class APIServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

	func testGetMostPopularArticles_Success() async throws {
		let json = """
		   {
			 "status": "OK",
			 "copyright": "Copyright (c) 2024 The New York Times Company.  All Rights Reserved.",
			 "num_results": 20,
			 "results": [
			   {
				 "uri": "nyt://article/d251dae2-753a-5298-933e-ba47799fb915",
				 "url": "https://www.nytimes.com/2024/12/04/opinion/guns-prison-regret-murder.html",
				 "id": 100000009844187,
				 "asset_id": 100000009844187,
				 "source": "New York Times",
				 "published_date": "2024-12-04",
				 "updated": "2024-12-04 15:39:40",
				 "section": "Opinion",
				 "subsection": "",
				 "nytdsection": "opinion",
				 "adx_keywords": "Prisons and Prisoners;Poverty;Criminal Justice;Washington (State)",
				 "column": null,
				 "byline": "By Christopher Blackwell",
				 "type": "Article",
				 "title": "I Should Never Have Picked Up That Gun",
				 "abstract": "I am surrounded by men who live with regret. And that regret is an incarceration every bit as real as the towering walls around us.",
				 "des_facet": [
				   "Prisons and Prisoners",
				   "Poverty",
				   "Criminal Justice"
				 ],
				 "org_facet": [],
				 "per_facet": [],
				 "geo_facet": [
				   "Washington (State)"
				 ],
				 "media": [
				   {
					 "type": "image",
					 "subtype": "photo",
					 "caption": "",
					 "copyright": "Kristina Tzekova",
					 "approved_for_syndication": 0,
					 "media-metadata": [
					   {
						 "url": "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-thumbStandard.jpg",
						 "format": "Standard Thumbnail",
						 "height": 75,
						 "width": 75
					   },
					   {
						 "url": "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-mediumThreeByTwo210.jpg",
						 "format": "mediumThreeByTwo210",
						 "height": 140,
						 "width": 210
					   },
					   {
						 "url": "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-mediumThreeByTwo440.jpg",
						 "format": "mediumThreeByTwo440",
						 "height": 293,
						 "width": 440
					   }
					 ]
				   }
				 ],
				 "eta_id": 0
			   },
			   {
				 "uri": "nyt://article/eabeb12c-2a20-5076-833b-0eab0ca55836",
				 "url": "https://www.nytimes.com/2024/11/26/well/high-intensity-binge-drinking-alcohol.html",
				 "id": 100000009773619,
				 "asset_id": 100000009773619,
				 "source": "New York Times",
				 "published_date": "2024-11-26",
				 "updated": "2024-12-04 16:06:22",
				 "section": "Well",
				 "subsection": "",
				 "nytdsection": "well",
				 "adx_keywords": "Alcohol Abuse;Middle Age (Demographic);Youth",
				 "column": null,
				 "byline": "By Christina Caron",
				 "type": "Article",
				 "title": "This Drinking Habit Is More Dangerous Than Bingeing",
				 "abstract": "And it’s on the rise among middle-aged drinkers.",
				 "des_facet": [
				   "Alcohol Abuse",
				   "Middle Age (Demographic)",
				   "Youth"
				 ],
				 "org_facet": [],
				 "per_facet": [],
				 "geo_facet": [],
				 "media": [
				   {
					 "type": "image",
					 "subtype": "photo",
					 "caption": "",
					 "copyright": "German Alvarez/Getty Images",
					 "approved_for_syndication": 1,
					 "media-metadata": [
					   {
						 "url": "https://static01.nyt.com/images/2024/12/03/well/WELL-INTENSITY-DRINKING/WELL-INTENSITY-DRINKING-thumbStandard.jpg",
						 "format": "Standard Thumbnail",
						 "height": 75,
						 "width": 75
					   },
					   {
						 "url": "https://static01.nyt.com/images/2024/12/03/well/WELL-INTENSITY-DRINKING/WELL-INTENSITY-DRINKING-mediumThreeByTwo210.jpg",
						 "format": "mediumThreeByTwo210",
						 "height": 140,
						 "width": 210
					   },
					   {
						 "url": "https://static01.nyt.com/images/2024/12/03/well/WELL-INTENSITY-DRINKING/WELL-INTENSITY-DRINKING-mediumThreeByTwo440.jpg",
						 "format": "mediumThreeByTwo440",
						 "height": 293,
						 "width": 440
					   }
					 ]
				   }
				 ],
				 "eta_id": 0
			   }
			 ]
		   }
		"""
		let data = json.data(using: .utf8)
		let response = HTTPURLResponse(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/")!,
									   statusCode: 200,
									   httpVersion: nil,
									   headerFields: nil)
		
		let session = URLSessionMock(mockData: data, mockResponse: response, mockError: nil)
		let service = NYTApiService(session: session)
		let articles = try await service.getMostPopularArticles()
		
		XCTAssertEqual(articles.count, 2)
		XCTAssertEqual(articles[0].id, 100000009844187)
	}
	
	func testGetMostPopularArticles_Error_NoData() async throws {
		let response = HTTPURLResponse(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/")!,
									   statusCode: 500,
									   httpVersion: nil,
									   headerFields: nil)
		
		let session = URLSessionMock(mockData: nil, mockResponse: response, mockError: nil)
		let service = NYTApiService(session: session)
		
		do {
			_ = try await service.getMostPopularArticles()
			XCTFail("Expected to failed")
		} catch let error {
			XCTAssertEqual((error as? URLError)?.code, URLError.badServerResponse)
		}
	}
	
	func testGetMostPopularArticles_Error_NoValidData() async throws {
		let json = """
		  {
			"status": "OK",
			"copyright": "Copyright (c) 2024 The New York Times Company.  All Rights Reserved.",
			"num_results": 20,
			"results": [
			  {
				"uri": "nyt://article/d251dae2-753a-5298-933e-ba47799fb915",
				"url": "https://www.nytimes.com/2024/12/04/opinion/guns-prison-regret-murder.html",
				"id": "abcdeftg",
				"asset_id": "100000009844187",
				"source": "New York Times",
				"published_date": "2024-12-04",
				"updated": "2024-12-04 15:39:40",
				"section": "Opinion",
				"subsection": "",
				"nytdsection": "opinion",
				"adx_keywords": "Prisons and Prisoners;Poverty;Criminal Justice;Washington (State)",
				"column": null,
				"byline": "By Christopher Blackwell",
				"type": "Article",
				"title": "I Should Never Have Picked Up That Gun",
				"abstract": "I am surrounded by men who live with regret. And that regret is an incarceration every bit as real as the towering walls around us.",
				"des_facet": [
				  "Prisons and Prisoners",
				  "Poverty",
				  "Criminal Justice"
				],
				"org_facet": [],
				"per_facet": [],
				"geo_facet": [
				  "Washington (State)"
				],
				"media": [
				  {
					"type": "image",
					"subtype": "photo",
					"caption": "",
					"copyright": "Kristina Tzekova",
					"approved_for_syndication": 0,
					"media-metadata2": [
					  {
						"url": "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-thumbStandard.jpg",
						"format": "Standard Thumbnails",
						"height": "75",
						"width": "75"
					  },
					  {
						"url": "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-mediumThreeByTwo210.jpg",
						"format": "mediumThreeByTwo210",
						"height": 140,
						"width": 210
					  },
					  {
						"url": "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-mediumThreeByTwo440.jpg",
						"format": "mediumThreeByTwo440",
						"height": 293,
						"width": 440
					  }
					]
				  }
				],
				"eta_id": 0
			  },
			  {
				"uri": "nyt://article/eabeb12c-2a20-5076-833b-0eab0ca55836",
				"url": "https://www.nytimes.com/2024/11/26/well/high-intensity-binge-drinking-alcohol.html",
				"id": "100000009773619",
				"asset_id": 100000009773619,
				"source": "New York Times",
				"published_date": "2024-11-26",
				"updated": "2024-12-04 16:06:22",
				"section": "Well",
				"subsection": "",
				"nytdsection": "well",
				"adx_keywords": "Alcohol Abuse;Middle Age (Demographic);Youth",
				"column": null,
				"byline": "By Christina Caron",
				"type": "Article",
				"title": "This Drinking Habit Is More Dangerous Than Bingeing",
				"abstract": "And it’s on the rise among middle-aged drinkers.",
				"des_facet": [
				  "Alcohol Abuse",
				  "Middle Age (Demographic)",
				  "Youth"
				],
				"org_facet": [],
				"per_facet": [],
				"geo_facet": [],
				"media": [
				  {
					"type": "image",
					"subtype": "photo",
					"caption": "",
					"copyright": "German Alvarez/Getty Images",
					"approved_for_syndication": 1,
					"media-metadata": [
					  {
						"url": "https://static01.nyt.com/images/2024/12/03/well/WELL-INTENSITY-DRINKING/WELL-INTENSITY-DRINKING-thumbStandard.jpg",
						"format": "Standard Thumbnail",
						"height": 75,
						"width": 75
					  },
					  {
						"url": "https://static01.nyt.com/images/2024/12/03/well/WELL-INTENSITY-DRINKING/WELL-INTENSITY-DRINKING-mediumThreeByTwo210.jpg",
						"format": "mediumThreeByTwo210",
						"height": 140,
						"width": 210
					  },
					  {
						"url": "https://static01.nyt.com/images/2024/12/03/well/WELL-INTENSITY-DRINKING/WELL-INTENSITY-DRINKING-mediumThreeByTwo440.jpg",
						"format": "mediumThreeByTwo440",
						"height": 293,
						"width": 440
					  }
					]
				  }
				],
				"eta_id": 0
			  }
			]
		  }
		"""
		let data = json.data(using: .utf8)
		let response = HTTPURLResponse(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/")!,
									   statusCode: 200,
									   httpVersion: nil,
									   headerFields: nil)
		
		let session = URLSessionMock(mockData: data, mockResponse: response, mockError: nil)
		let service = NYTApiService(session: session)
		
		do {
			_ = try await service.getMostPopularArticles()
			XCTFail("Expected to failed")
		} catch let error as APIError {
			XCTAssertEqual(error, .decodingError)
		}
	}
	
	func testGetMostPopularArticles_Error_NoValidApiKey() async throws {
		let json = """
		   {
			 "fault": {
			   "faultstring": "Failed to resolve API Key variable request.queryparam.api-key",
			   "detail": {
				 "errorcode": "steps.oauth.v2.FailedToResolveAPIKey"
			   }
			 }
		   }
		"""
		let data = json.data(using: .utf8)
		let response = HTTPURLResponse(url: URL(string: "https://api.nytimes.com/svc/mostpopular/v2/")!,
									   statusCode: 401,
									   httpVersion: nil,
									   headerFields: nil)
		
		let session = URLSessionMock(mockData: data, mockResponse: response, mockError: nil)
		let service = NYTApiService(session: session)
		
		do {
			_ = try await service.getMostPopularArticles()
			XCTFail("Expected to failed")
		} catch let error as APIError {
			XCTAssertEqual(error, .apiKeyInvalid)
		}
	}
}
