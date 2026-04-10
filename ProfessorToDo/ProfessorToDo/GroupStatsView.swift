//
//  GroupStatsView.swift
//  ProfessorToDo
//
//  Created for MDI-117 Class
//

import SwiftUI

struct GroupStatsView: View {
    let completedCount: Int
    let totalCount: Int
    let percentage: Double
    
    var body: some View {
        HStack(spacing: 20) {
            // Progress Circle
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: CGFloat(percentage / 100))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: percentage)
                
                Text("\(Int(percentage))%")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            
            // Stats Text
            VStack(alignment: .leading, spacing: 5) {
                Text("\(completedCount) / \(totalCount) Completed")
                    .font(.headline)
                
                Text(statusMessage)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
    }
    
    private var statusMessage: String {
        if totalCount == 0 {
            return "No tasks yet"
        } else if completedCount == totalCount {
            return "All done! 🎉"
        } else if percentage >= 50 {
            return "Almost there!"
        } else {
            return "Keep going!"
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        GroupStatsView(completedCount: 5, totalCount: 10, percentage: 50)
            .padding()
        
        GroupStatsView(completedCount: 10, totalCount: 10, percentage: 100)
            .padding()
        
        GroupStatsView(completedCount: 0, totalCount: 0, percentage: 0)
            .padding()
    }
}
