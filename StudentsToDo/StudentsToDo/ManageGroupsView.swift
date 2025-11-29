//
//  ManageGroupsView.swift
//  MDI 114 Class 3 TodoTrackerApp
//
//  Created by SDGKU on 04/11/25.
//

import SwiftUI

struct ManageGroupsView: View {
    
    @Binding var groups: [TaskGroup]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storeManager: StoreManager
    @State private var showUpgradeAlert = false
    var appAccentColor: Color
    @State private var newGroupName: String = ""
    @State private var newGroupIcon: String = "checklist"
    private let groupIcons = [
        "checklist", "star.fill", "briefcase.fill", "heart.fill", "book.fill", "house.fill", "person.fill", "cart.fill", "airplane", "banknote.fill"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add New Group") {
                    TextField("Group Name (e.g., Work)", text: $newGroupName)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical, 4)
                        .accessibilityIdentifier("newGroupNameTextField")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(groupIcons, id: \.self) { icon in
                                Button {
                                    newGroupIcon = icon
                                } label: {
                                    Image(systemName: icon)
                                        .font(.title2)
                                        .foregroundStyle(newGroupIcon == icon ? .white : appAccentColor)
                                        .frame(width: 50, height: 50)
                                        .background(newGroupIcon == icon ? appAccentColor : Color(.systemGray5))
                                        .clipShape(Circle())
                                }
                                .animation(.snappy, value: newGroupIcon)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .padding(.horizontal, -10)
                    
                    Button {
                        
                        if storeManager.canAddGroup(currentGroupCount: groups.count) {
                            addNewGroup()
                        } else {
                            showUpgradeAlert = true
                        }
                        
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add New Group")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(appAccentColor)
                    .padding(.vertical, 5)
                    .disabled(newGroupName.isEmpty)
                    .accessibilityIdentifier("addNewGroupButton")
                }
                
                Section("Manage Groups") {
                    if groups.isEmpty {
                        Text("No groups yet. Add one above!")
                            .foregroundStyle(.secondary)
                    }
                    
                    ForEach($groups) { $group in
                        HStack(spacing: 15) {
                            Image(systemName: group.symbolName)
                                .font(.title2)
                                .foregroundStyle(appAccentColor)
                                .frame(width: 30, height: 30)
                                .padding(8)
                                .background(appAccentColor.opacity(0.1))
                                .clipShape(Circle())
                            
                            TextField("Group Name", text: $group.title)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteGroup)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Manage Groups")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.headline)
                    .accessibilityIdentifier("Done")
                }
            }
            .alert("Upgrade to Pro", isPresented: $showUpgradeAlert) {
                Button("Upgrade for $1.99") {
                    storeManager.buyProVersion()
                    }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("You can you only create 3 groups for free. Upgrade to Pro to remove this limit.")
            }
        }
        .tint(appAccentColor) 
    }
        
    private func addNewGroup() {
        withAnimation {
            let newGroup = TaskGroup(
                title: newGroupName,
                symbolName: newGroupIcon,
                tasks: []
            )
            groups.append(newGroup)
            
            newGroupName = ""
            newGroupIcon = "checklist"
        }
    }
    
    private func deleteGroup(at offsets: IndexSet) {
        groups.remove(atOffsets: offsets)
    }
}
