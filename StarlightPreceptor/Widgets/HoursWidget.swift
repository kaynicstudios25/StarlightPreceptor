//
//  HoursWidget.swift
//  Starlight Preceptor
//
//  Created by Kaylyn Groom on 2/4/26.
//

import Foundation
import SwiftUI
import SwiftData

struct HoursWidget: View {
    @Query(sort: \Hours.date, order: .reverse) var hours: [Hours]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                // Header
                HStack {
                    Image(systemName: "clock.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                    
                    Text("Hours Logged")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.black)
                        
                    
                    Spacer()
                    
                    NavigationLink {
                        LogHoursView()
                    } label: {
                        Text("Log hours")
                            .font(.caption)
                            .foregroundStyle(.blue)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    
                }
                
                // Stats
                HStack(spacing: 20) {
                    StatView(
                        title: "Total Hours",
                        value: "\(totalHours)",
                        systemImage: "sum"
                    )
                    
                    StatView(
                        title: "This Week",
                        value: "\(hoursThisWeek)",
                        systemImage: "calendar.badge.clock"
                    )
                    
                    StatView(
                        title: "Students",
                        value: "\(uniqueStudents)",
                        systemImage: "person.2.fill"
                    )
                }
                
                // Recent entries preview
                if !hours.isEmpty {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        ForEach(hours.prefix(3)) { hour in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(hour.student_name)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                    Text(hour.date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundStyle(.black)
                                }
                                Spacer()
                                Text("\(hour.hours)h")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // Computed properties for stats
    private var totalHours: Int {
        hours.reduce(0) { $0 + $1.hours }
    }
    
    private var hoursThisWeek: Int {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())?.start ?? Date()
        
        return hours
            .filter { $0.date >= startOfWeek }
            .reduce(0) { $0 + $1.hours }
    }
    
    private var uniqueStudents: Int {
        Set(hours.map { $0.student_name }).count
    }
}

// Helper view for individual stats
struct StatView: View {
    let title: String
    let value: String
    let systemImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.caption)
                Text(title)
                    .font(.caption)
            }
            .foregroundStyle(.black)
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HoursWidget()
        .modelContainer(for: Hours.self, inMemory: true)
        .padding()
}


