//
//  MostPopularView.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//

import SwiftUI

struct MostPopularView: View {
	@StateObject private var viewModel = MostPopularViewModel()
	
	init() {
		let appear = UINavigationBarAppearance()
		appear.largeTitleTextAttributes = [.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 34)!]
		appear.titleTextAttributes = [.font: UIFont(name: "BodoniSvtyTwoOSITCTT-Bold", size: 20)!]
		UINavigationBar.appearance().standardAppearance = appear
		UINavigationBar.appearance().compactAppearance = appear
		UINavigationBar.appearance().scrollEdgeAppearance = appear
	 }
	
    var body: some View {
		NavigationView {
			VStack {
				if viewModel.useCacheOnly {
					HStack {
						Spacer()
						Text("No internet connection, using cached data")
						Spacer()
					}
					.padding(.vertical)
					.background(.yellow.opacity(0.8))
				}
				Picker(viewModel.currentService.rawValue.capitalized, selection: $viewModel.currentService) {
					Text("Viewed").tag(ServiceType.viewed)
					Text("Emailed").tag(ServiceType.emailed)
					Text("Shared").tag(ServiceType.shared)
				}
				.onChange(of: viewModel.currentService, { _, _ in
					Task {
						await viewModel.fetchMostPopularArticles()
					}
				})
				.pickerStyle(.segmented)
				.padding([.top, .horizontal])
				.padding(.bottom, 3)
				
				if let errorMessage = viewModel.error, viewModel.articles.isEmpty {
					VStack {
						Spacer()
						Text(errorMessage)
							.foregroundColor(.red)
							.multilineTextAlignment(.center)
							.padding()
						Button("Retry") {
							Task {
								await viewModel.fetchMostPopularArticles()
							}
						}
						.padding()
						.buttonStyle(.borderedProminent)
						Spacer()
					}
				} else {
					List {
						ForEach(viewModel.articles, id:\.url) { article in
							if article.id % 2 == 0 {
								NavigationLink(destination: ArticleDetailView(article: article)) {
									ArticleMediumView(article: article)
								}
							} else {
								NavigationLink(destination: ArticleDetailView(article: article)) {
									ArticleRegularView(article: article)
								}
							}
						}
					}
					.listStyle(.plain)
					.animation(.easeIn, value: viewModel.articles)
					.navigationTitle("Most Popular")
					.toolbar {
						ToolbarItem(placement:.automatic) {
							Menu {
								ForEach(PeriodType.allCases, id: \.self) { period in
									Button(period.toString()) {
										viewModel.selectedPeriod = period
										Task {
											await viewModel.fetchMostPopularArticles()
										}
									}
								}
							} label: {
								Text("Period")
									.font(.custom("BodoniSvtyTwoOSITCTT-Book", size: 18))
									.foregroundStyle(.foreground)
							}

						}
					}
					.task {
						await viewModel.fetchMostPopularArticles()
					}
				}
			}
		}
		
    }
}

#Preview {
    MostPopularView()
}
