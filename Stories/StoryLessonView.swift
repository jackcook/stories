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
    
    var fileName: String! {
        didSet {
            guard let path = Bundle.main.path(forResource: fileName, ofType: "html") else {
                return
            }
            
            var contents = ""
            
            do {
                contents = try String(contentsOfFile: path)
            } catch {
                print("error retrieving contents of file: \(path)")
            }
            
            let localPath = Bundle.main.bundlePath
            let baseURL = URL(fileURLWithPath: localPath)
            
            webView.loadHTMLString(contents, baseURL: baseURL)
        }
    }
    
    override func awakeFromNib() {
        webView.backgroundColor = UIColor.white
    }
}
