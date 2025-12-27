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
            RootRouterView()
                .environmentObject(appModel)
        }
        .modelContainer(for: [
            TaskDefinition.self, // من TaskBank.swift
            ChildProfile.self    // موديل بيانات الطفل
        ])
    }
}

// هذا الـ View يقرر شاشة البداية بناءً على وجود بيانات محفوظة في SwiftData
private struct RootRouterView: View {
    @Query private var profiles: [ChildProfile]

    var body: some View {
        if let profile = profiles.first {
            // إذا فيه ملف طفل محفوظ → نمرر البيانات إلى AppModel لضمان التوافق
            RootTabBootstrapView(profile: profile)
        } else {
            // لا يوجد بيانات محفوظة → ابدأ بتجربة الترحيب المعتادة
            NavigationStack {
                WelcomeView()
            }
        }
    }
}

// يربط البيانات المحفوظة بـ AppModel ثم يفتح RootTabView
private struct RootTabBootstrapView: View {
    @EnvironmentObject private var appModel: AppModel
    let profile: ChildProfile

    var body: some View {
        TabBootstrapper()
            .onAppear {
                // عيّن القيم في AppModel ليستمر بقية التطبيق بالعمل كما هو
                appModel.parentName = profile.parentName
                appModel.childName = profile.childName
                appModel.childLevel = ChildLevel(rawValue: profile.childLevelRaw) ?? .beginner

                // تأكد من توليد مهام اليوم
                appModel.ensureTasksForToday()
            }
    }
}

// التفاف بسيط يعرض RootTabView داخل NavigationStack (مطابق لباقي أسلوبك)
private struct TabBootstrapper: View {
    var body: some View {
        NavigationStack {
            RootTabView()
                .navigationBarBackButtonHidden(true)
        }
    }
}
