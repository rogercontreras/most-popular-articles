//
//  MediaItem.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 06/12/24.
//


struct MediaItem: Codable, Hashable {
	var type: String
	var subtype: String
	var copyright: String
	var mediaMetadata: [MediaMetadata]
	
	var thumbnailUrl: String? {
		mediaMetadata.first(where: { $0.format == "Standard Thumbnail" })?.url
	}
	
	var largeImageUrl: String? {
		mediaMetadata.first(where: { $0.format == "mediumThreeByTwo440" })?.url
	}
	
	enum CodingKeys: String, CodingKey {
		case type
		case subtype
		case copyright
		case mediaMetadata = "media-metadata"
	}
}