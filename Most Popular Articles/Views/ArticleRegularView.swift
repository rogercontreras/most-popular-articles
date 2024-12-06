//
//  ArticleRegularView.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 05/12/24.
//

import SwiftUI

struct ArticleRegularView: View {
	let article: Article
	private let customFont = Font.custom("BodoniSvtyTwoOSITCTT-Bold", size: 23)
	
    var body: some View {
		VStack(alignment:.leading) {
			//Text(article.section)
			Text(article.section)
				.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 16))
				.padding(.all, 3)
				.background(.tertiary)
			HStack {
				VStack(alignment:.leading) {
					Text(article.title)
						.font(customFont)
					Spacer()
				}
				Spacer()
				VStack {
					if let thumbnailUrl = article.thumbnailUrl {
						AsyncCachedImage(url: URL(string: thumbnailUrl)) { img in
							img.resizable().aspectRatio(contentMode: .fill)
						} placeholder: {
							Color.gray
						}
						.frame(width: 75, height: 75)
					}
					Spacer()
				}
			}.padding(.top, 8)
			Text(article.summary)
				.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 16))
				.foregroundStyle(.secondary)
				.lineLimit(3)
		}
		.padding(.vertical)
    }
}

//#Preview {
//    ArticleRegularView()
//}
