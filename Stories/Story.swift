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
            Story(thumbnail: #imageLiteral(resourceName: "Story 2 Thumbnail"), name: "Lesson 2", topics: "Numbers", parts: [
                StoryReading(text:[
                        "Marie: Bonjour mon ami! Comment ça va?",
                        "Jean: Salut! Ça va bien, merci. Et toi?",
                        "Marie: Ça va bien. Quelle est la date?",
                        "Jean: Aujourd'hui est le dix-sept Septembre, deux milleseize.",
                        "Marie: Pouvez-vous aller au supermarché pour acheter moi des fruits? Le pique-nique est aujourd'hui!",
                        "Jean: Oui! Quels fruits?",
                        "Marie: Je voudrais deux pommes, cinq poires, et sept oranges, s'il vous plaît.",
                        "Jean: Combien ça vont coûter en tout?",
                        "Marie: Je pense que c'est quinze (15) francs.",
                        "Jean: À quelle distance se trouve le supermarché?",
                        "Marie: Il se trouve à vingt (20) minutes à pied, c'est sur rue cent-dix. Merci Beaucoup!",
                        "Jean: De rien!"
                    ].joined(separator: "\n"),
                    translations: [
                        "":"",
                    ]),
                StoryLesson(fileName: "numbers")
            ]),
            Story(thumbnail: #imageLiteral(resourceName: "Story 3 Thumbnail"), name: "Lesson 3", topics: "Adjectives", parts: [
                StoryLesson(fileName: "adjectives")
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
