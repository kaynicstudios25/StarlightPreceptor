//
//  RootView.swift
//  MyFirstProject
//
//  Created by Kaylyn Groom on 2/3/26.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
            ScheduleView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
            LogHoursView()
                .tabItem {
                    Label("Log Hours", systemImage: "pencil")
                }
            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: "bubble.right")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tabViewStyle(.automatic)
    }
}

#Preview {
    ContentView()
}
