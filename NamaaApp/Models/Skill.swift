import SwiftUI

struct Skill: Identifiable, Hashable {
    // Use systemImage as a stable unique id
    let id: String
    let title: String
    let subtitle: String
    let color: Color
    let systemImage: String

    static let all: [Skill] = [
        Skill(id: "brain.head.profile",
              title: "Cognitive Skills",
              subtitle: "Thinking, memory, and attention",
              color: .appBlue,
              systemImage: "brain.head.profile"),
        Skill(id: "bubble.left.and.bubble.right.fill",
              title: "Communication Skills",
              subtitle: "Language, speech, and expression",
              color: .appYellow,
              systemImage: "bubble.left.and.bubble.right.fill"),
        Skill(id: "person.3.fill",
              title: "Social Skills",
              subtitle: "Interaction with others",
              color: .appBlue,
              systemImage: "person.3.fill"),
        Skill(id: "figure.walk",
              title: "Motor Skills",
              subtitle: "Movement and interaction",
              color: .appYellow,
              systemImage: "figure.walk")
    ]
}
