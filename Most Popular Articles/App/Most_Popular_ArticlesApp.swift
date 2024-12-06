//
//  Most_Popular_ArticlesApp.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//

import SwiftUI
import SwiftData

@main
struct Most_Popular_ArticlesApp: App {

    var body: some Scene {
        WindowGroup {
			MostPopularView().navigationSplitViewStyle(.prominentDetail)
        }
    }
}
