import SwiftUI
import Combine

final class ProgressViewModel: ObservableObject {
    private let appModel: AppModel

    init(appModel: AppModel) {
        self.appModel = appModel
    }

    var parentName: String { appModel.parentName }
    var childName: String { appModel.childName }
    var dailyStatusText: String { appModel.dailyStatusText }
    var selectedSkills: Set<Skill> { appModel.selectedSkills }
    var todayHistory: [HistoryEntry] { appModel.todayHistory }

    func ensureTasksForToday() {
        appModel.ensureTasksForToday()
    }

    func averageProgress(for title: String) -> Double {
        appModel.averageProgressForSkill(title: title)
    }
}
