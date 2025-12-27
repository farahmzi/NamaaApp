import Foundation
import SwiftData

@Model
final class ChildProfile {
    var parentName: String
    var childName: String
    var childLevelRaw: String

    init(parentName: String, childName: String, childLevelRaw: String) {
        self.parentName = parentName
        self.childName = childName
        self.childLevelRaw = childLevelRaw
    }
}
