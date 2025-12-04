//
//  ContentView.swift
//  NamaaApp
//
//  Created by Farah Almozaini on 24/11/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appModel = AppModel()

    var body: some View {
        NavigationStack {
            WelcomeView()
                .navigationDestination(for: String.self) { route in
                    if route == "rootTabs" {
                        RootTabView()
                            .navigationBarBackButtonHidden(true)
                    } else {
                        EmptyView()
                    }
                }
        }
        .environmentObject(appModel)
    }
}

#Preview {
    ContentView()
}
