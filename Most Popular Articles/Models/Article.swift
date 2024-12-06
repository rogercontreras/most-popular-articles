//
//  Article.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//
struct MostPopularResponse: Codable {
	let results: [Article]
}

struct Article: Identifiable, Codable, Hashable {
	var id: Int
	var title: String
	var summary: String
	var byline: String
	var url: String
	var publishedDate: String
	var section: String
	var media: [MediaItem]
	
	var thumbnailUrl: String? {
		media.first?.mediaMetadata.first(where: { $0.format == "Standard Thumbnail" })?.url
	}
	
	var largeImageUrl: String? {
		media.first?.mediaMetadata.first(where: { $0.format == "mediumThreeByTwo440" })?.url
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case summary = "abstract"
		case byline
		case url
		case publishedDate = "published_date"
		case media
		case section
	}
}




