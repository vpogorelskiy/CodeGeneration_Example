//
//  OTUS_Homework_2App.swift
//  Shared
//
//  Created by Вячеслав Погорельский on 20.09.2021.
//

import SwiftUI

@main
struct OTUS_Homework_2App: App {
    
    init() {
        ViewBuilder.registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
