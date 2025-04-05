//
//  RememberMeApp.swift
//  RememberMe
//
//  Created by Rishal Bazim on 04/04/25.
//

import SwiftData
import SwiftUI

@main
struct RememberMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
