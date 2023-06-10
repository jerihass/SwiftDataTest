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
    var id: UUID
    var name: String
    var number: Int
    
    init(timestamp: Date, name: String = "MyName", number: Int = 1) {
        self.timestamp = timestamp
        self.id = UUID()
        self.name = name
        self.number = number
    }
}
