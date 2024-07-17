//
//  Memento_MoriApp.swift
//  Memento Mori
//
//  Created by Javier Fransiscus on 17/07/24.
//

import SwiftUI

@main
struct Memento_MoriApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData())
        }
    }
}
