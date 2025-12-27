//
//  NamaaAppApp.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI
import SwiftData

@main
struct NamaaAppApp: App {
    @StateObject private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
            .environmentObject(appModel)
        }
        .modelContainer(for: [
            TaskDefinition.self, // من TaskBank.swift
            ChildProfile.self    // موديل بيانات الطفل
        ])
    }
}
