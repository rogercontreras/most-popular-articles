//
//  Item.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
