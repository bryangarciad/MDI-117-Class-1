//
//  ContentView.swift
//  ProfessorToDo
//
//  Created for MDI-117 Class
//

import SwiftUI

struct ContentView: View {
	    @EnvironmentObject var dataManager: ProfileDataManager
	    @Environment(\.scenePhase) var scenePhase
	    
	    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.blue)
                    
                    Text("Who is working today?")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top, 50)
                
	                // Profile Cards
	                ScrollView {
	                    VStack(spacing: 20) {
	                        ForEach(Array(dataManager.profiles.enumerated()), id: \.element.id) { index, element in
	                            NavigationLink {
	                                DashboardView(profile: $dataManager.profiles[index])
	                            } label: {
	                                ProfileCardView(profile: element)
	                            }
	                            .accessibilityIdentifier("profileCard_\(element.name)")
	                        }
	                    }
	                    .padding(.horizontal)
	                }
                
                Spacer()
            }
	            .navigationTitle("ProfessorToDo")
	            .navigationBarTitleDisplayMode(.inline)
	        }
	        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .background:
                // Save data when app goes to background
                dataManager.saveProfiles()
                print("📱 App moved to background - data saved")
            case .active:
                print("📱 App became active")
            case .inactive:
                print("📱 App became inactive")
            @unknown default:
                break
            }
        }
    }
}

// MARK: - Profile Card View
struct ProfileCardView: View {
    let profile: Profile

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Profile Header
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.blue)

                Text(profile.name)
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
            }

            Divider()

            // Stats
            GroupStatsView(
                completedCount: profile.completedTasksCount,
                totalCount: profile.totalTasksCount,
                percentage: profile.completionPercentage
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(ProfileDataManager())
}
