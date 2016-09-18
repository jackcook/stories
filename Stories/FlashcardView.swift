//
//  FlashcardView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class FlashcardView: UIView {
    
    fileprivate var frontView: UIView!
    fileprivate var frontLabel: UILabel!
    
    fileprivate var backView: UIView!
    fileprivate var backLabel: UILabel!
    fileprivate var dontKnowButton: UIButton!
    fileprivate var knowButton: UIButton!
    
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
            frontLabel.font = UIFont.systemFont(ofSize: 42)
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
            backLabel.font = UIFont.systemFont(ofSize: 42)
            backLabel.text = translation
            backLabel.textColor = UIColor.black
            backView.addSubview(backLabel)
        }
        backLabel.sizeToFit()
        backLabel.frame = CGRect(x: (backView.bounds.width - backLabel.bounds.width) / 2, y: (backView.bounds.height - backLabel.bounds.height) / 2, width: backLabel.bounds.width, height: backLabel.bounds.height)
        
        if dontKnowButton == nil {
            dontKnowButton = UIButton()
            dontKnowButton.addTarget(self, action: #selector(dontKnowButtonPressed(sender:)), for: .touchUpInside)
            dontKnowButton.backgroundColor = UIColor.main
            dontKnowButton.layer.cornerRadius = 4
            dontKnowButton.setTitle("Don't know", for: .normal)
            dontKnowButton.setTitleColor(UIColor.white, for: .normal)
            dontKnowButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            backView.addSubview(dontKnowButton)
        }
        let buttonSize = CGSize(width: (bounds.width - 16 * 3) / 2, height: 42)
        dontKnowButton.frame = CGRect(x: 16, y: bounds.height - 16 - buttonSize.height, width: buttonSize.width, height: buttonSize.height)
        
        let dontKnowShadowPath = UIBezierPath(rect: dontKnowButton.bounds)
        dontKnowButton.layer.masksToBounds = false
        dontKnowButton.layer.shadowColor = UIColor.black.cgColor
        dontKnowButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        dontKnowButton.layer.shadowOpacity = 0.3
        dontKnowButton.layer.shadowPath = dontKnowShadowPath.cgPath
        
        if knowButton == nil {
            knowButton = UIButton()
            knowButton.addTarget(self, action: #selector(knowButtonPressed(sender:)), for: .touchUpInside)
            knowButton.backgroundColor = UIColor.main
            knowButton.layer.cornerRadius = 4
            knowButton.setTitle("Know", for: .normal)
            knowButton.setTitleColor(UIColor.white, for: .normal)
            knowButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            backView.addSubview(knowButton)
        }
        knowButton.frame = CGRect(x: bounds.width / 2 + 8, y: bounds.height - 16 - buttonSize.height, width: buttonSize.width, height: buttonSize.height)
        
        let knowShadowPath = UIBezierPath(rect: knowButton.bounds)
        knowButton.layer.masksToBounds = false
        knowButton.layer.shadowColor = UIColor.black.cgColor
        knowButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        knowButton.layer.shadowOpacity = 0.3
        knowButton.layer.shadowPath = knowShadowPath.cgPath
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
    
    @objc fileprivate func dontKnowButtonPressed(sender: UIButton) {
        NotificationCenter.default.post(name: FlashcardsView.dontKnowFlashcard, object: nil)
    }
    
    @objc fileprivate func knowButtonPressed(sender: UIButton) {
        NotificationCenter.default.post(name: FlashcardsView.knowFlashcard, object: nil)
    }
}
