//
//  TaskGroupDetailView.swift
//  ProfessorToDo
//
//  Created for MDI-117 Class
//

import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var groups: TaskGroup
    @State private var newTaskTitle = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Stats Header
            GroupStatsView(
                completedCount: groups.completedTasksCount,
                totalCount: groups.totalTasksCount,
                percentage: groups.completionPercentage
            )
            .padding()
            .background(Color(.systemGray6))
            
            // Task List
            List {
                ForEach($groups.tasks) { $task in
                    TaskRowView(task: $task)
                }
                .onDelete(perform: deleteTask)
            }
            .listStyle(.plain)
            
            // Add Task Input
            HStack {
                TextField("New task...", text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        addTask()
                    }
                
                Button(action: addTask) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                .accessibilityIdentifier("addTaskButton")
                .disabled(newTaskTitle.isEmpty)
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .navigationTitle(groups.title)
        .navigationBarTitleDisplayMode(.large)
    }
    
    private func addTask() {
        guard !newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let newTask = Task(title: newTaskTitle, isCompleted: false)
        groups.tasks.append(newTask)
        newTaskTitle = ""
        isTextFieldFocused = false
    }
    
    private func deleteTask(at offsets: IndexSet) {
        groups.tasks.remove(atOffsets: offsets)
    }
}

// MARK: - Task Row View
struct TaskRowView: View {
    @Binding var task: Task
    
    var body: some View {
        HStack(spacing: 15) {
            // Completion Toggle
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundStyle(task.isCompleted ? .green : .gray)
                .onTapGesture {
                    withAnimation {
                        task.isCompleted.toggle()
                    }
                }
                .accessibilityIdentifier("taskCompletionToggle_\(task.title)")
            
            // Task Title
            Text(task.title)
                .font(.body)
                .strikethrough(task.isCompleted)
                .foregroundStyle(task.isCompleted ? .gray : .primary)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        TaskGroupDetailView(
            groups: .constant(
                TaskGroup(
                    title: "Work Tasks",
                    symbolName: "briefcase.fill",
                    tasks: [
                        Task(title: "Complete report", isCompleted: true),
                        Task(title: "Review code", isCompleted: false),
                        Task(title: "Team meeting", isCompleted: false)
                    ]
                )
            )
        )
    }
}
