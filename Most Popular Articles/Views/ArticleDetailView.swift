//
//  ArticleDetailView.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//

import SwiftUI

struct ArticleDetailView: View {
	let article: Article
	
	init(article: Article) {
		self.article = article
		let appear = UINavigationBarAppearance()
		appear.largeTitleTextAttributes = [.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 34)!]
		appear.titleTextAttributes = [.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 20)!]
		UINavigationBar.appearance().standardAppearance = appear
		UINavigationBar.appearance().compactAppearance = appear
		UINavigationBar.appearance().scrollEdgeAppearance = appear
	 }
	
    var body: some View {
		NavigationView {
			ScrollView {
				VStack(alignment: .leading) {
					if let largeImageUrl = article.largeImageUrl {
						AsyncCachedImage(url: URL(string: largeImageUrl)) { img in
							img.resizable()
								.aspectRatio(contentMode: .fill)
								.clipped()
						} placeholder: {
							Color.gray
						}
						.frame(height: 280)
						.frame(maxWidth: .infinity)
						.clipped()
					}
					Text(article.title)
						.font(Font.custom("BodoniSvtyTwoOSITCTT-Bold", size: 30))
						.bold()
						.padding([.top, .horizontal])
					Divider()
					HStack {
						Text(article.publishedDate)
							.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 14))
						Spacer()
						Text(article.section)
							.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 14))
					}
					.padding(.horizontal)
					.padding(.bottom, 4)
					Text(article.byline)
						.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 16))
						.padding(.horizontal)
					Text(article.summary)
						.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 18))
						.padding()
					Spacer()
					Link("Read full article", destination: URL(string: article.url)!)
						.foregroundStyle(.foreground)
						.padding()
						.overlay(RoundedRectangle(cornerRadius: 10).stroke(.foreground))
						.frame(maxWidth: .infinity)
				}
				.padding(.horizontal)
			}
			.navigationTitle("Details")
			.navigationBarTitleDisplayMode(.inline)
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
	ArticleDetailView(article: article)
}
