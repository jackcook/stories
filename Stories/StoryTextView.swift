//
//  StoryTextView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class StoryTextView: UIView, NSLayoutManagerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    fileprivate var tooltipView: TooltipView!
    fileprivate var tooltipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.layoutManager.delegate = self
        
        let tgr = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        textView.addGestureRecognizer(tgr)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if tooltipView == nil {
            tooltipView = TooltipView()
            tooltipView.text = ""
            addSubview(tooltipView)
        }
        
//        if tooltipView == nil {
//            tooltipView = UIView()
//            tooltipView.backgroundColor = UIColor.black
//            tooltipView.frame = CGRect.zero
//            addSubview(tooltipView)
//        }
//        
//        if tooltipLabel == nil {
//            tooltipLabel = UILabel()
//            tooltipLabel.textColor = UIColor.white
//            tooltipView.addSubview(tooltipLabel)
//        }
//        tooltipLabel.sizeToFit()
//        tooltipLabel.frame = CGRect(x: (tooltipView.bounds.width - tooltipLabel.bounds.width) / 2, y: (tooltipView.bounds.height - tooltipLabel.bounds.height) / 2, width: tooltipLabel.bounds.width, height: tooltipLabel.bounds.height)
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 8
    }
    
    func tapped(sender: UITapGestureRecognizer) {
        var pos = sender.location(in: textView)
        pos.y += textView.contentOffset.y
        
        guard let tapPos = textView.closestPosition(to: pos) else {
            return
        }
        
        guard let range = textView.tokenizer.rangeEnclosingPosition(tapPos, with: .word, inDirection: UITextLayoutDirection.right.rawValue) else {
            return
        }
        
        guard let word = textView.text(in: range) else {
            return
        }
        
//        tooltipLabel.text = word
//        tooltipLabel.sizeToFit()
        
        let wordFrame = convert(textView.firstRect(for: range), from: textView)
        tooltipView.focusPoint = CGPoint(x: wordFrame.origin.x + wordFrame.size.width / 2, y: wordFrame.origin.y)
        tooltipView.text = word
        
//        let tooltipWidth = tooltipLabel.bounds.width + 16
//        tooltipView.frame = CGRect(x: wordFrame.origin.x + (wordFrame.size.width - tooltipWidth) / 2, y: wordFrame.origin.y - tooltipLabel.bounds.height - 12, width: tooltipWidth, height: tooltipLabel.bounds.height + 8)
//        
//        setNeedsLayout()
        
        print("\(word): \(CGPoint(x: wordFrame.origin.x + wordFrame.size.width / 2, y: wordFrame.origin.y))")
    }
}
