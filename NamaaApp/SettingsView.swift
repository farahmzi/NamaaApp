//
//  SettingsView.swift
//  NamaaApp
//
//  Created by Assistant on 02/12/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("Account") {
                Text("Profile")
                Text("Notifications")
            }
            Section("About") {
                Text("Terms of Service")
                Text("Privacy Policy")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack { SettingsView() }
}
