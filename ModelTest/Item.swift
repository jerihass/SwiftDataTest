//
//  Item.swift
//  ModelTest
//
//  Created by Jericho Hasselbush on 6/9/23.
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
