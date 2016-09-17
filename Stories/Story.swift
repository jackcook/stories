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
    
    static func getFirstStory() -> Story {
        return Story(thumbnail: #imageLiteral(resourceName: "story_1_thumbnail"), name: "Chapter 1", topics: "Greetings")
    }
}
