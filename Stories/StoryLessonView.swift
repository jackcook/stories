//
//  StoryLessonView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class StoryLessonView: UIView {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let path = Bundle.main.path(forResource: "verbs-and-pronouns", ofType: "html") else {
            return
        }
        
        var contents = ""
        
        do {
            contents = try String(contentsOfFile: path)
        } catch {
            print("error retrieving contents of file: \(path)")
        }
        
        webView.loadHTMLString(contents, baseURL: nil)
    }
}
