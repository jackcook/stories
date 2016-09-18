//
//  FlashcardsView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class FlashcardsView: UIView {
    
    static let dontKnowFlashcard = Notification.Name("dontKnowFlashcard")
    static let knowFlashcard = Notification.Name("knowFlashcard")
    
    fileprivate var currentFlashcard: FlashcardView?
    fileprivate var nextFlashcard: FlashcardView?
    
    fileprivate var canLayoutSubviews = true
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        currentFlashcard = FlashcardView(word: "bonjour", translation: "hello")
        addSubview(currentFlashcard!)
        
        NotificationCenter.default.addObserver(forName: FlashcardsView.dontKnowFlashcard, object: nil, queue: OperationQueue.main) { (notification) in
            self.newFlashcard(knew: false)
        }
        
        NotificationCenter.default.addObserver(forName: FlashcardsView.knowFlashcard, object: nil, queue: OperationQueue.main) { (notification) in
            self.newFlashcard(knew: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard canLayoutSubviews else {
            return
        }
        
        currentFlashcard?.frame = CGRect(x: 24, y: 24, width: bounds.width - 48, height: bounds.height - 48)
    }
    
    func newFlashcard(knew: Bool) {
        canLayoutSubviews = false
        
        nextFlashcard = FlashcardView(word: "bonjour", translation: "hello")
        addSubview(nextFlashcard!)
        
        nextFlashcard?.frame = CGRect(x: 24, y: bounds.height + 24, width: bounds.width - 48, height: bounds.height - 48)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.currentFlashcard?.frame.origin.x += self.bounds.width * (knew ? 1 : -1)
        }, completion: { (done) in
            UIView.animate(withDuration: 0.25, delay: 0.1, animations: {
                self.nextFlashcard?.frame = CGRect(x: 24, y: 24, width: self.bounds.width - 48, height: self.bounds.height - 48)
            }, completion: { (done) in
                self.currentFlashcard?.removeFromSuperview()
                self.currentFlashcard = nil
                
                self.currentFlashcard = self.nextFlashcard
                self.nextFlashcard = nil
                
                self.canLayoutSubviews = true
            })
        })
    }
}
