//
//  ListMarketApp.swift
//  ListMarket
//
//  Created by Diego on 06-06-21.
//

import SwiftUI

@main
struct ListMarketApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
