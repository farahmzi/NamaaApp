//
//  RootTabView.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationStack {
                Progressview()
            }
            .tabItem {
                Image(systemName: "chart.bar.fill")
                Text("Progress")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
    }
}

#Preview {
    RootTabView().environmentObject(AppModel())
}
