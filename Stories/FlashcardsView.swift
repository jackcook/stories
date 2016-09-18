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
    
    fileprivate var noticeLabel: UILabel!
    
    fileprivate var currentFlashcard: FlashcardView?
    fileprivate var nextFlashcard: FlashcardView?
    
    fileprivate var canLayoutSubviews = true
    fileprivate var currentWord: String!
    fileprivate var vocabulary = [String: String]()
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        for story in Story.stories() {
            for part in story.parts {
                if let part = part as? StoryReading {
                    for (word, translation) in part.translations {
                        vocabulary[word] = translation
                    }
                }
            }
        }
        
        currentWord = Array(vocabulary.keys)[Int(arc4random_uniform(UInt32(vocabulary.count)))]
        currentFlashcard = FlashcardView(word: currentWord, translation: vocabulary[currentWord]!)
        addSubview(currentFlashcard!)
        
        NotificationCenter.default.addObserver(forName: FlashcardsView.dontKnowFlashcard, object: nil, queue: OperationQueue.main) { (notification) in
            self.newFlashcard(knew: false)
        }
        
        NotificationCenter.default.addObserver(forName: FlashcardsView.knowFlashcard, object: nil, queue: OperationQueue.main) { (notification) in
            self.vocabulary.removeValue(forKey: self.currentWord)
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
        
        if noticeLabel == nil {
            noticeLabel = UILabel()
            noticeLabel.alpha = 0
            noticeLabel.font = UIFont.systemFont(ofSize: 28)
            noticeLabel.numberOfLines = 0
            noticeLabel.text = "You've reviewed all of your flashcards for now!"
            noticeLabel.textAlignment = .center
            noticeLabel.textColor = UIColor.black
            addSubview(noticeLabel)
        }
        let size = noticeLabel.textRect(forBounds: CGRect(x: 0, y: 0, width: bounds.width - 48, height: CGFloat.greatestFiniteMagnitude), limitedToNumberOfLines: 0)
        noticeLabel.frame = CGRect(x: 24, y: (bounds.height - size.height) / 2, width: bounds.width - 48, height: size.height)
    }
    
    func newFlashcard(knew: Bool) {
        guard vocabulary.count > 0 else {
            canLayoutSubviews = false
            
            UIView.animate(withDuration: 0.25, animations: {
                self.currentFlashcard?.frame.origin.x += self.bounds.width * (knew ? 1 : -1)
                self.noticeLabel.alpha = 1
            }, completion: { (done) in
                self.currentFlashcard?.removeFromSuperview()
                self.currentFlashcard = nil
                
                self.canLayoutSubviews = true
            })
            
            return
        }
        
        canLayoutSubviews = false
        
        currentWord = Array(vocabulary.keys)[Int(arc4random_uniform(UInt32(vocabulary.count)))]
        nextFlashcard = FlashcardView(word: currentWord, translation: vocabulary[currentWord]!)
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
