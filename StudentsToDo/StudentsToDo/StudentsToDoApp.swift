//
//  StudentsToDoApp.swift
//  StudentsToDo
//
//  Created by SDGKU on 10/11/25.
//

import SwiftUI

@main
struct StudentsToDoApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.locale) var locale
    @StateObject private var storeManager = StoreManager()
    
    private var dynamicAccentColor: Color {
        if locale.language.languageCode?.identifier == "ar" {
            return .brown
        } else {
            return .cyan
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.appAccentColor, dynamicAccentColor)
                .environmentObject(storeManager)
        }
    }
}
