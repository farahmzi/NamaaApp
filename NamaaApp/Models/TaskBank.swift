//
//  TaskBank.swift
//  NamaaApp
//
//  Created by Assistant on 03/12/2025.
//

import Foundation
import SwiftData

@Model
final class TaskDefinition: Hashable {
    var title: String
    var category: String // must match Skill.title
    var icon: String     // must match Skill.systemImage
    var steps: [String]

    init(title: String, category: String, icon: String, steps: [String]) {
        self.title = title
        self.category = category
        self.icon = icon
        self.steps = steps
    }

    // Conformance to Hashable so it can be used in sets/keys if needed
    static func == (lhs: TaskDefinition, rhs: TaskDefinition) -> Bool {
        lhs.title == rhs.title && lhs.category == rhs.category && lhs.icon == rhs.icon && lhs.steps == rhs.steps
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(category)
        hasher.combine(icon)
        hasher.combine(steps)
    }
}

enum TaskBank {
    static func tasks(for skill: Skill) -> [TaskDefinition] {
        switch skill.systemImage {
        case "brain.head.profile":
            return cognitive
        case "bubble.left.and.bubble.right.fill":
            return communication
        case "person.3.fill":
            return social
        case "figure.walk":
            return motor
        default:
            return []
        }
    }

    // MARK: - Cognitive Development (Cognitive Skills)
    // Focus: Memory, sequencing, matching, and early math/literacy.
    static let cognitive: [TaskDefinition] = [
        TaskDefinition(
            title: "The Sock Match",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Place a pile of unmatched socks on the floor or table.",
                "Ask your child to find two socks that look exactly the same.",
                "Have them fold the pair together and put it in a basket."
            ]
        ),
        TaskDefinition(
            title: "Table Setter",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Count out the number of family members eating dinner (e.g., 4).",
                "Ask your child to count out that many forks and plates.",
                "Have them place one fork and one plate at each chair."
            ]
        ),
        TaskDefinition(
            title: "Color Scavenger Hunt",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Show your child a specific color (e.g., a red card or toy).",
                "Set a timer for 2 minutes.",
                "Ask them to find 3 items in the room that match that color."
            ]
        ),
        TaskDefinition(
            title: "Story Sequencing",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Read a short, familiar book together.",
                "Ask, \"What happened first?\" and wait for an answer.",
                "Ask, \"What happened at the end?\" to check their memory."
            ]
        ),
        TaskDefinition(
            title: "Big to Small",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Gather 5 similar objects of different sizes (e.g., books, bowls, or shoes).",
                "Ask your child to point to the biggest one.",
                "Have them line the objects up from biggest to smallest."
            ]
        ),
        TaskDefinition(
            title: "Money Match",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Place three different coins (e.g., penny, dime, quarter) on the table.",
                "Place a second set of the same coins in a pile.",
                "Ask your child to pick a coin from the pile and place it next to its match."
            ]
        ),
        TaskDefinition(
            title: "Pattern Maker",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Start a simple pattern with colored blocks (e.g., Red, Blue, Red, Blue).",
                "Ask your child, \"What color comes next?\"",
                "Have them place the correct block to continue the pattern."
            ]
        ),
        TaskDefinition(
            title: "Memory Tray",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Put 3 household items on a tray (e.g., spoon, key, toy) and let them look for 10 seconds.",
                "Cover the tray with a towel.",
                "Ask them to name (or draw) the items hidden under the towel."
            ]
        ),
        TaskDefinition(
            title: "Shape Sorter (Real Life)",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Point to a shape, like a circle (e.g., a clock or plate).",
                "Walk to the kitchen or living room together.",
                "Ask your child to find two other things that are circles."
            ]
        ),
        TaskDefinition(
            title: "What’s Missing?",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Line up 3 familiar toys on the table.",
                "Have your child close their eyes while you take one toy away.",
                "Ask them to open their eyes and tell you which toy is missing."
            ]
        ),
        TaskDefinition(
            title: "Category Sorting",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Mix a pile of toy animals and toy cars together.",
                "Place two boxes out, one marked for animals and one for cars.",
                "Have them sort the items into the correct boxes."
            ]
        ),
        TaskDefinition(
            title: "Puzzle Master",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Dump out a puzzle (15–25 pieces).",
                "Ask your child to find all the edge (straight) pieces first.",
                "Connect the corners together before filling in the middle."
            ]
        ),
        TaskDefinition(
            title: "Letter Hunt",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Write the first letter of your child's name on a piece of paper.",
                "Give them a magazine or cereal box.",
                "Ask them to circle that letter every time they see it."
            ]
        ),
        TaskDefinition(
            title: "Daily Schedule Check",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Show your child pictures of morning tasks (brush teeth, get dressed, eat).",
                "Ask, \"What do we do first?\"",
                "Ask, \"What do we do after that?\" to practice sequencing."
            ]
        ),
        TaskDefinition(
            title: "Opposites Game",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Say a word like \"Hot.\"",
                "Ask your child to say the opposite (e.g., \"Cold\").",
                "Repeat with Up/Down, In/Out, and Big/Small."
            ]
        ),
        TaskDefinition(
            title: "Counting Steps",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Stand at the bottom of a staircase or hallway.",
                "Walk forward together.",
                "Count every step out loud together until you reach 10 or 20."
            ]
        ),
        TaskDefinition(
            title: "I Spy Numbers",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Go for a walk or look out the window.",
                "Ask your child to find a number (e.g., on a license plate or sign).",
                "Have them read the number out loud."
            ]
        ),
        TaskDefinition(
            title: "Build a Tower",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Give your child a set of blocks or plastic cups.",
                "Show them a picture or model of a 5-level tower.",
                "Ask them to copy the model exactly."
            ]
        ),
        TaskDefinition(
            title: "Body Part Identification",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Stand in front of a mirror together.",
                "Ask, \"Where are your elbows?\"",
                "Have them touch their elbows, then knees, then ears."
            ]
        ),
        TaskDefinition(
            title: "Stop and Go",
            category: "Cognitive Skills",
            icon: "brain.head.profile",
            steps: [
                "Explain that \"Red\" means stop and \"Green\" means go.",
                "Hold up a green object and have them walk fast.",
                "Hold up a red object and have them freeze immediately."
            ]
        )
    ]

    // MARK: - Communication (Communication Skills)
    static let communication: [TaskDefinition] = [
        TaskDefinition(
            title: "The Choice Maker",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Hold up two different snacks or toys.",
                "Ask, \"Do you want the apple or the banana?\"",
                "Wait for them to say the specific word before giving it."
            ]
        ),
        TaskDefinition(
            title: "Animal Sounds",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Show a picture of an animal (e.g., cow, sheep).",
                "Ask, \"What sound does this animal make?\"",
                "Have them make the sound loud and clear."
            ]
        ),
        TaskDefinition(
            title: "Mirror Speech",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Sit in front of a mirror with your child.",
                "Make a silly face and a sound (like \"Oooh\" or \"Eeee\").",
                "Ask them to copy your mouth shape and sound."
            ]
        ),
        TaskDefinition(
            title: "Preposition Practice",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Give your child a favorite toy.",
                "Give an instruction: \"Put the toy under the chair.\"",
                "Give a new instruction: \"Put the toy on the table.\""
            ]
        ),
        TaskDefinition(
            title: "Story Retell",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Watch a short 2-minute cartoon clip together.",
                "Turn off the screen.",
                "Ask, \"Tell me one thing the character did.\""
            ]
        ),
        TaskDefinition(
            title: "Guess Who?",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Describe a family member with a couple of clues.",
                "Ask your child to guess who it is.",
                "Switch roles and have them describe someone for you to guess."
            ]
        ),
        TaskDefinition(
            title: "Telephone Game",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Sit close to your child.",
                "Whisper a simple word in their ear.",
                "Have them whisper it back to you or another person."
            ]
        ),
        TaskDefinition(
            title: "Sing-Along",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Play a familiar song.",
                "Sing together for a few lines.",
                "Stop the music and ask them to sing the next word."
            ]
        ),
        TaskDefinition(
            title: "Action Verbs",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Say an action word like \"Jump,\" \"Sleep,\" or \"Eat.\"",
                "Ask your child to act it out.",
                "Ask them to say the word while doing the action."
            ]
        ),
        TaskDefinition(
            title: "The Why Game",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Ask a simple question like, \"Why do we wear a coat?\"",
                "Help them form the answer: \"Because it is cold.\"",
                "Repeat with another simple \"Why\" question."
            ]
        ),
        TaskDefinition(
            title: "Slow Down Speech",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Choose a long word (like \"Caterpillar\").",
                "Clap your hands for each syllable.",
                "Have your child clap and say the parts slowly with you."
            ]
        ),
        TaskDefinition(
            title: "Grocery List Helper",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Open the fridge together.",
                "Point to an empty spot and say, \"We need milk.\"",
                "Ask them to repeat, \"We need milk.\""
            ]
        ),
        TaskDefinition(
            title: "Feeling Words",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Make a sad face.",
                "Ask, \"How am I feeling?\"",
                "Have them say \"Sad\" and then make a sad face too."
            ]
        ),
        TaskDefinition(
            title: "Barrier Game",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Put a book between you so you can't see each other's hands.",
                "Tell them to draw a circle on their paper.",
                "Remove the book to see if your drawings match."
            ]
        ),
        TaskDefinition(
            title: "Show and Tell",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Ask your child to pick one toy.",
                "Ask them to tell you the name of the toy.",
                "Ask them to tell you one thing the toy does."
            ]
        ),
        TaskDefinition(
            title: "Bubble Pop Talk",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Blow bubbles.",
                "Catch a bubble on the wand.",
                "Have the child say \"Pop!\" before they poke it."
            ]
        ),
        TaskDefinition(
            title: "Yes or No",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Ask a silly question (e.g., \"Do cows fly?\").",
                "Encourage them to answer with a firm \"No.\"",
                "Ask a real question (\"Do fish swim?\") for a \"Yes.\""
            ]
        ),
        TaskDefinition(
            title: "Loud and Quiet",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Say \"Hello\" in a very loud voice.",
                "Say \"Hello\" in a whisper voice.",
                "Ask your child to copy the loud and whisper versions."
            ]
        ),
        TaskDefinition(
            title: "Naming Kitchen Items",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Pick up a spoon, cup, and bowl.",
                "Hold up one item at a time.",
                "Have the child name each object quickly."
            ]
        ),
        TaskDefinition(
            title: "My Day",
            category: "Communication Skills",
            icon: "bubble.left.and.bubble.right.fill",
            steps: [
                "Sit down at dinner or bedtime.",
                "Ask, \"What did you play today?\"",
                "Help them say a simple sentence (e.g., \"I played ball\")."
            ]
        )
    ]

    // MARK: - Social Skills
    static let social: [TaskDefinition] = [
        TaskDefinition(
            title: "The Turn-Taking Ball",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Sit on the floor facing each other.",
                "Say \"My turn\" and roll the ball to your child.",
                "Encourage them to say \"My turn\" before rolling it back."
            ]
        ),
        TaskDefinition(
            title: "Emotion Charades",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Draw a face (happy, angry, surprised) on a paper.",
                "Act out that face with your own expression.",
                "Ask your child to guess the feeling and copy the face."
            ]
        ),
        TaskDefinition(
            title: "The Greeting Game",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Pretend to leave the room and come back in.",
                "Walk up to your child, look them in the eye, and say \"Hi!\"",
                "Have them look at you and say \"Hi\" back."
            ]
        ),
        TaskDefinition(
            title: "Sharing Snack",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Give your child a bowl of crackers.",
                "Ask them to give one cracker to you and one to a sibling/toy.",
                "Praise them for sharing (\"Good sharing!\")."
            ]
        ),
        TaskDefinition(
            title: "Eye Contact Contest",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Sit close to your child.",
                "Challenge them to look into your eyes without blinking or looking away.",
                "Count to 5 while holding eye contact."
            ]
        ),
        TaskDefinition(
            title: "Personal Space Hoop",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Place a hula hoop (or circle of string) on the floor.",
                "Explain that this is their \"space bubble.\"",
                "Practice standing in the bubble while talking without stepping out."
            ]
        ),
        TaskDefinition(
            title: "Restaurant Play",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Pretend to be a waiter.",
                "Ask your child, \"What would you like to eat?\"",
                "Have them place an order nicely (\"Burger, please\")."
            ]
        ),
        TaskDefinition(
            title: "Board Game Basics",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Set up a simple board game.",
                "Roll the dice.",
                "Wait for the child to wait for their turn without grabbing the dice."
            ]
        ),
        TaskDefinition(
            title: "High-Five Helper",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Ask your child to help you with a small task.",
                "Once done, hold up your hand.",
                "Have them give you a high-five and say \"Good job!\""
            ]
        ),
        TaskDefinition(
            title: "Name Game",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Sit in a circle with family or toys.",
                "Hold a ball.",
                "Say the name of the person you are throwing to before throwing it."
            ]
        ),
        TaskDefinition(
            title: "Asking to Play",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Roleplay where you are playing with a toy.",
                "Coach your child to come over and ask, \"Can I play?\"",
                "Say \"Yes\" and play together."
            ]
        ),
        TaskDefinition(
            title: "Apology Practice",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Pretend to accidentally bump into a toy.",
                "Say \"Oops, I'm sorry.\"",
                "Have the child practice saying \"I'm sorry.\""
            ]
        ),
        TaskDefinition(
            title: "Compliment Circle",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Sit with your child.",
                "Say one nice thing about them.",
                "Ask them to say one nice thing about you."
            ]
        ),
        TaskDefinition(
            title: "Waiting in Line",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Place a favorite toy at the end of the hallway.",
                "Stand in front of your child so they have to wait behind you.",
                "Move forward slowly, encouraging them to wait their turn."
            ]
        ),
        TaskDefinition(
            title: "Tone of Voice",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Say a sentence in an angry voice.",
                "Say the same sentence in a happy voice.",
                "Ask the child which voice sounded \"friendly.\""
            ]
        ),
        TaskDefinition(
            title: "Help a Friend",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Pretend to drop something and say \"Oh no!\"",
                "Wait for your child to notice.",
                "Encourage them to pick it up and give it to you."
            ]
        ),
        TaskDefinition(
            title: "Funny Face Contest",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Sit facing each other.",
                "Try to make the other person laugh by making a face.",
                "The first person to laugh loses."
            ]
        ),
        TaskDefinition(
            title: "The Please Rule",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Give your child a treat only when they use the magic word.",
                "Wait for them to ask.",
                "If they forget, prompt \"What do you say?\" until they say \"Please.\""
            ]
        ),
        TaskDefinition(
            title: "Gentle Touch",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Use a stuffed animal or pet.",
                "Show how to stroke it gently.",
                "Have the child copy the \"gentle\" motion."
            ]
        ),
        TaskDefinition(
            title: "Wave Goodbye",
            category: "Social Skills",
            icon: "person.3.fill",
            steps: [
                "Pretend to leave the house.",
                "Say \"Bye-bye!\"",
                "Have the child wave their hand and say \"Bye.\""
            ]
        )
    ]

    // MARK: - Motor Skills
    static let motor: [TaskDefinition] = [
        TaskDefinition(
            title: "Pasta Threading",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Give your child a piece of uncooked spaghetti or a string.",
                "Give them a bowl of tube pasta (penne).",
                "Have them thread 10 pieces of pasta onto the string/spaghetti."
            ]
        ),
        TaskDefinition(
            title: "The Flamingo Stand",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Have your child stand next to a wall for safety.",
                "Ask them to lift one foot up.",
                "Count how many seconds they can balance on one leg."
            ]
        ),
        TaskDefinition(
            title: "Play-Doh Pinch",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Roll play-doh into a long snake.",
                "Ask your child to use their thumb and pointer finger.",
                "Have them pinch along the snake to make \"spikes.\""
            ]
        ),
        TaskDefinition(
            title: "Line Walking",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Put a strip of tape on the floor in a straight line.",
                "Ask your child to walk on the tape like a tightrope.",
                "Ensure they put one foot directly in front of the other."
            ]
        ),
        TaskDefinition(
            title: "Coin Drop",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Cut a small slit in the lid of a plastic container.",
                "Give your child 10 coins.",
                "Have them push the coins through the slit one by one."
            ]
        ),
        TaskDefinition(
            title: "Scissor Skills",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Draw a thick straight line on a piece of paper.",
                "Help your child hold scissors with their thumb up.",
                "Have them cut along the line from bottom to top."
            ]
        ),
        TaskDefinition(
            title: "Ball Catch",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Stand 3 feet away from your child.",
                "Toss a large soft ball gently to their chest.",
                "Have them catch it with both hands."
            ]
        ),
        TaskDefinition(
            title: "Paper Crumple",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Give your child a piece of scrap paper.",
                "Ask them to use only one hand.",
                "Crumple the paper into a tight ball using that one hand."
            ]
        ),
        TaskDefinition(
            title: "Sticker Peel",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Give your child a sheet of stickers.",
                "Ask them to peel one sticker off using their fingers.",
                "Stick it inside a drawn circle on a paper."
            ]
        ),
        TaskDefinition(
            title: "Animal Walk: Bear",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Clear a space on the floor.",
                "Have your child put hands and feet on the floor (legs straight, bottom up).",
                "Walk across the room on hands and feet like a bear."
            ]
        ),
        TaskDefinition(
            title: "Button Practice",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Get a shirt with large buttons.",
                "Ask your child to push the button through the hole.",
                "Practice doing 3 buttons in a row."
            ]
        ),
        TaskDefinition(
            title: "Pillow Jump",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Place a flat pillow on the floor.",
                "Have your child stand in front of it with feet together.",
                "Ask them to jump with two feet onto the pillow."
            ]
        ),
        TaskDefinition(
            title: "Tweezer Transfer",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Place cotton balls in one bowl and leave an empty bowl next to it.",
                "Give your child a pair of tweezers or kitchen tongs.",
                "Have them move the cotton balls one by one to the empty bowl."
            ]
        ),
        TaskDefinition(
            title: "Wall Push-Ups",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Have your child stand facing a wall, arms length away.",
                "Place hands flat on the wall.",
                "Bend elbows to bring nose close to wall, then push back (5 times)."
            ]
        ),
        TaskDefinition(
            title: "Zip It Up",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Put on a jacket with a zipper.",
                "Connect the bottom pin of the zipper (help if needed).",
                "Have the child pull the zipper tab all the way up."
            ]
        ),
        TaskDefinition(
            title: "Balloon Tap",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Blow up a balloon.",
                "Toss it in the air.",
                "Have the child keep tapping it up so it doesn't touch the floor."
            ]
        ),
        TaskDefinition(
            title: "Clothespin Clip",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Give your child a box rim or a piece of cardboard.",
                "Give them 5 clothespins.",
                "Have them squeeze the pins and clip them onto the edge of the cardboard."
            ]
        ),
        TaskDefinition(
            title: "Obstacle Course",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Set up two chairs.",
                "Have the child crawl under the first chair.",
                "Have them walk around the second chair."
            ]
        ),
        TaskDefinition(
            title: "Water Pouring",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Give your child a small pitcher of water and an empty cup.",
                "Have them pour water into the cup.",
                "Stop pouring before the cup overflows."
            ]
        ),
        TaskDefinition(
            title: "Frog Jumps",
            category: "Motor Skills",
            icon: "figure.walk",
            steps: [
                "Squat down low like a frog.",
                "Touch the floor with hands between knees.",
                "Jump up high and land back in a squat."
            ]
        )
    ]
}
