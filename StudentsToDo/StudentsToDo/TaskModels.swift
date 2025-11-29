//
//  TaskModels.swift
//  TodoAppTask
//
//  Created by SDGKU on 01/11/25.
//

import Foundation
import SwiftUI

struct TaskItem: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool = false
    var creationDate: Date

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, creationDate: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.creationDate = creationDate
    }
}

struct TaskGroup: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
    
    init(id: UUID = UUID(), title:String, symbolName:String, tasks:[TaskItem]) {
        self.id = id
        self.title = title
        self.symbolName = symbolName
        self.tasks = tasks
    }
}

struct ProfileCategory: Identifiable {
    let id = UUID()
    let name: LocalizedStringKey
    let imageName: String
    let storageKey: String
}

enum SidebarSelection: Hashable {
    case group(TaskGroup.ID)
    case profile
}
