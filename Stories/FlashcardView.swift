//
//  FlashcardView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class FlashcardView: UIView {
    
    var frontView: UIView!
    var frontLabel: UILabel!
    var backView: UIView!
    var backLabel: UILabel!
    
    fileprivate var word: String!
    fileprivate var translation: String!
    
    init(word: String, translation: String) {
        super.init(frame: CGRect.zero)
        
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.word = word
        self.translation = translation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if frontView == nil {
            frontView = UIView()
            frontView.backgroundColor = UIColor.white
            addSubview(frontView)
        }
        frontView.frame = bounds
        
        if frontLabel == nil {
            frontLabel = UILabel()
            frontLabel.font = UIFont(name: "Georgia", size: 36)
            frontLabel.text = word
            frontLabel.textColor = UIColor.black
            frontView.addSubview(frontLabel)
        }
        frontLabel.sizeToFit()
        frontLabel.frame = CGRect(x: (frontView.bounds.width - frontLabel.bounds.width) / 2, y: (frontView.bounds.height - frontLabel.bounds.height) / 2, width: frontLabel.bounds.width, height: frontLabel.bounds.height)
        
        if backView == nil {
            backView = UIView()
            backView.backgroundColor = UIColor.white
        }
        backView.frame = bounds
        
        if backLabel == nil {
            backLabel = UILabel()
            backLabel.font = UIFont(name: "Georgia", size: 36)
            backLabel.text = translation
            backLabel.textColor = UIColor.black
            backView.addSubview(backLabel)
        }
        backLabel.sizeToFit()
        backLabel.frame = CGRect(x: (backView.bounds.width - backLabel.bounds.width) / 2, y: (backView.bounds.height - backLabel.bounds.height) / 2, width: backLabel.bounds.width, height: backLabel.bounds.height)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if subviews.contains(frontView) {
            UIView.transition(with: self, duration: 0.25, options: .transitionFlipFromRight, animations: {
                self.frontView.removeFromSuperview()
                self.addSubview(self.backView)
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 0.25, options: .transitionFlipFromLeft, animations: { 
                self.backView.removeFromSuperview()
                self.addSubview(self.frontView)
            }, completion: nil)
        }
    }
}
