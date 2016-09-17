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
    
    var text: String! {
        didSet {
            textView.text = text
        }
    }
    
    fileprivate var tooltipView: TooltipView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.layoutManager.delegate = self
        textView.text = text
        
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
        
        let wordFrame = convert(textView.firstRect(for: range), from: textView)
        tooltipView.focusPoint = CGPoint(x: wordFrame.origin.x + wordFrame.size.width / 2, y: wordFrame.origin.y)
        tooltipView.text = word
    }
}
