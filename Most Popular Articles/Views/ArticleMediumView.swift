//
//  ArticleMediumView.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 05/12/24.
//

import SwiftUI

struct ArticleMediumView: View {
	let article: Article
	
    var body: some View {
		VStack(alignment: .leading) {
			ZStack {
				if let largeImageUrl = article.largeImageUrl {
					AsyncCachedImage(url: URL(string: largeImageUrl)) { img in
						img.resizable()
							.aspectRatio(contentMode: .fill)
							.clipped()
					} placeholder: {
						Color.gray
					}
					.frame(height: 200)
					.frame(maxWidth: .infinity)
					.clipped()
				}
				VStack(alignment:.leading) {
					HStack {
						Text(article.section)
							.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 16))
							.padding(.all, 3)
							.background(.white)
							.foregroundStyle(.black)
							.padding(.top)
						Spacer()
					}
					Spacer()
				}
			}
			Text(article.title)
				.font(.custom("BodoniSvtyTwoOSITCTT-Bold", size: 23))
			Text(article.summary)
				.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 16))
				.foregroundStyle(.foreground)
				.lineLimit(3)
		}
    }
}

#Preview {
	let mediaItem = MediaItem(type: "image",
							  subtype: "photo",
							  copyright: "Kristina Tzekova",
							  mediaMetadata: [
								MediaMetadata(url: "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-thumbStandard.jpg", width: 75, height: 75, format: "Standard Thumbnail"),
								MediaMetadata(url: "https://static01.nyt.com/images/2024/12/04/opinion/04blackwell-image/04blackwell-image-mediumThreeByTwo440.jpg", width: 293, height: 440, format: "mediumThreeByTwo440")
							  ])
	let article = Article(id: 0,
			title: "I Should Never Have Picked Up That Gun",
			summary: "I am surrounded by men who live with regret. And that regret is an incarceration every bit as real as the towering walls around us.",
			byline: "By Christopher Blackwell",
			url: "https://www.nytimes.com/2024/12/04/opinion/guns-prison-regret-murder.html",
						  publishedDate: "2024-12-04", section: "Opinion",
						  media: [mediaItem])
	ArticleMediumView(article: article)
}
