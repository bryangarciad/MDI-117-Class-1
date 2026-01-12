//
//  TaskModels.swift
//  ProfessorToDo
//
//  Created for MDI-117 Class
//

import Foundation

// MARK: - Task Model
struct Task: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - TaskGroup Model
struct TaskGroup: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [Task]
    
    var completedTasksCount: Int {
        tasks.filter { $0.isCompleted }.count
    }
    
    var totalTasksCount: Int {
        tasks.count
    }
    
    var completionPercentage: Double {
        guard totalTasksCount > 0 else { return 0 }
        return Double(completedTasksCount) / Double(totalTasksCount) * 100
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TaskGroup, rhs: TaskGroup) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Profile Model
struct Profile: Identifiable, Codable {
    var id = UUID()
    var name: String
    var groups: [TaskGroup]
    
    var totalTasksCount: Int {
        groups.reduce(0) { $0 + $1.totalTasksCount }
    }
    
    var completedTasksCount: Int {
        groups.reduce(0) { $0 + $1.completedTasksCount }
    }
    
    var completionPercentage: Double {
        guard totalTasksCount > 0 else { return 0 }
        return Double(completedTasksCount) / Double(totalTasksCount) * 100
    }
}

// MARK: - Data Manager for UserDefaults Persistence
class ProfileDataManager: ObservableObject {
    @Published var profiles: [Profile] = []
    
    private let userDefaultsKey = "SavedProfiles"
    
    init() {
        loadProfiles()
        
        // If no profiles exist, create sample data
        if profiles.isEmpty {
            createSampleProfiles()
        }
    }
    
    // MARK: - Save to UserDefaults
    func saveProfiles() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(profiles)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            print("✅ Profiles saved successfully")
        } catch {
            print("❌ Failed to save profiles: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Load from UserDefaults
    func loadProfiles() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            print("ℹ️ No saved profiles found")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            profiles = try decoder.decode([Profile].self, from: data)
            print("✅ Profiles loaded successfully")
        } catch {
            print("❌ Failed to load profiles: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Create Sample Data
    private func createSampleProfiles() {
        profiles = [
            Profile(name: "Professor", groups: [
                TaskGroup(title: "Lectures", symbolName: "graduationcap.fill", tasks: [
                    Task(title: "Prepare iOS lecture", isCompleted: true),
                    Task(title: "Review student submissions", isCompleted: false)
                ]),
                TaskGroup(title: "Research", symbolName: "book.fill", tasks: [
                    Task(title: "Read latest SwiftUI papers", isCompleted: false),
                    Task(title: "Write research proposal", isCompleted: false)
                ])
            ]),
            Profile(name: "Student", groups: [
                TaskGroup(title: "Homework", symbolName: "pencil", tasks: [
                    Task(title: "Complete iOS assignment", isCompleted: false),
                    Task(title: "Study for exam", isCompleted: false)
                ])
            ])
        ]
        saveProfiles()
    }
}
