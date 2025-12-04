//
//  RootTabView.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var appModel: AppModel

    var body: some View {
        TabView(selection: $appModel.selectedTab) {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            NavigationStack {
                Progressview()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Progress")
            }
            .tag(1)

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Profile")
            }
            .tag(2)
        }
    }
}

#Preview {
    RootTabView().environmentObject(AppModel())
}

