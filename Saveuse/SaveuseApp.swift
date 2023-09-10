//
//  SaveuseApp.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import SwiftUI
import SwiftData

@main
struct SaveuseApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
