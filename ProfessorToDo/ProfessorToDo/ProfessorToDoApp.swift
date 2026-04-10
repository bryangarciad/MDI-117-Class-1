//
//  ProfessorToDoApp.swift
//  ProfessorToDo
//
//  Created for MDI-117 Class
//

import SwiftUI

@main
struct ProfessorToDoApp: App {
    @StateObject private var dataManager = ProfileDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
        }
    }
}
