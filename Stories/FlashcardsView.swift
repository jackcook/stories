//
//  FlashcardsView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class FlashcardsView: UIView {
    
    fileprivate var currentFlashcard: FlashcardView?
    fileprivate var nextFlashcard: FlashcardView?
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        currentFlashcard = FlashcardView(word: "bonjour", translation: "hello")
        addSubview(currentFlashcard!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        currentFlashcard?.frame = CGRect(x: 24, y: 24, width: bounds.width - 48, height: bounds.height - 48)
    }
}
