//
//  HomeView.swift
//  StudentsToDo
//
//  Created by SDGKU on 11/11/25.
//

import SwiftUI

struct HomeView: View {
    // ADD THIS ONE LINE:
        @Environment(\.appAccentColor) var appAccentColor
    
    private let profiles = [
        ProfileCategory(name: "School", imageName: "SchoolCover", storageKey: "school_data"),
        ProfileCategory(name: "Work", imageName: "WorkCover", storageKey: "work_data"),
        ProfileCategory(name: "Personal", imageName: "PersonalCover", storageKey: "personal_data")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {
                    welcomeHeader
                    profileGrid
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }
    
    private var welcomeHeader: some View {
        VStack(spacing: 10) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .font(.system(size: 80))
                .foregroundStyle(appAccentColor)
            
            Text("Welcome Back")
                .font(.largeTitle.bold())
                .accessibilityIdentifier("welcome_back")
            
            Text("Select a workspace to begin")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 50)
    }
    
    private var profileGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(profiles) { profile in
                NavigationLink(destination: ContentView(storageKey: profile.storageKey, profileTitle: profile.name)) {
                    ProfileCard(profile: profile)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier(profile.storageKey)
            }
        }
        .padding(.horizontal, 80)
    }
}

struct ProfileCard: View {
    let profile: ProfileCategory
    @Environment(\.appAccentColor) var appAccentColor
    var body: some View {
        VStack {
            Image(profile.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .clipped()
                .overlay(Color.black.opacity(0.2))
            
            HStack {
                Text(profile.name)
                    .font(.title3.bold())
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right.circle.fill")
                    .font(.title2)
                    .foregroundStyle(appAccentColor)
                    .flipsForRightToLeftLayoutDirection(true)
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
    }
}
