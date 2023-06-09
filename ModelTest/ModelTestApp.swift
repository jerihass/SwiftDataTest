//
//  ModelTestApp.swift
//  ModelTest
//
//  Created by Jericho Hasselbush on 6/9/23.
//

import SwiftUI
import SwiftData

@main
struct ModelTestApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
