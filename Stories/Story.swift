//
//  Story.swift
//  Stories
//
//  Created by Jack Cook on 9/16/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

struct Story {
    
    var thumbnail: UIImage
    var name: String
    var topics: String
    var parts: [StoryPart]
    
    static func stories() -> [Story] {
        return [
            Story(thumbnail: #imageLiteral(resourceName: "Story 1 Thumbnail"), name: "Lesson 1", topics: "Greetings", parts: [
                StoryReading(text: [
                        "Marie: Salut Jean. Ça va?",
                        "Jean: Ça va bien, merci. Et toi, ça va?",
                        "Marie: Pas mal.",
                        "Jean: Quoi de neuf?",
                        "Marie: Pas grand-chose.",
                        "Marie: Au revoir Jean.",
                        "Jean: Au revoir, à demain.",
                    ].joined(separator: "\n"),
                    translations: [
                        "salut": "hello",
                        "bien": "good",
                        "merci": "thank you",
                        "quoi": "what",
                        "toi": "you"
                    ]),
                StoryLesson(fileName: "verbs-and-pronouns")
            ]),
            Story(thumbnail: #imageLiteral(resourceName: "Story 1 Thumbnail"), name: "Lesson 2", topics: "Numbers", parts: [
                StoryLesson(fileName: "numbers")
            ])
        ]
    }
}

protocol StoryPart {
    
}

struct StoryReading: StoryPart {
    var text: String
    var translations: [String: String]
}

struct StoryLesson: StoryPart {
    var fileName: String
}

struct StoryExercise: StoryPart {
    
}
