//
//  TooltipView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class TooltipView: UIView {
    
    var focusPoint = CGPoint.zero {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var text: String = "" {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    fileprivate var label: UILabel!
    
    init() {
        label = UILabel()
        label.font = UIFont(name: "Georgia", size: 18)
        label.text = ""
        label.textColor = UIColor.black
        
        super.init(frame: CGRect.zero)
        
        addSubview(label)
        backgroundColor = UIColor.white
        
        layer.cornerRadius = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.text = text
        label.sizeToFit()
        
        let size = CGSize(width: label.bounds.width + 16, height: label.bounds.height + 8)
        
        label.frame = CGRect(x: (size.width - label.bounds.width) / 2, y: (size.height - label.bounds.height) / 2, width: label.bounds.width, height: label.bounds.height)
        
        frame = CGRect(x: focusPoint.x - size.width / 2, y: focusPoint.y - size.height - 4, width: size.width, height: size.height)
        
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.15
        layer.shadowPath = shadowPath.cgPath
    }
}
