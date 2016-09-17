//
//  TabBarView.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    var delegate: TabBarViewDelegate?
    var selectedTab = 0
    
    private var tabViews = [TabView]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tabWidth = bounds.width / CGFloat(tabViews.count)
        
        var x: CGFloat = 0
        for tab in tabViews {
            tab.frame = CGRect(x: x, y: 0, width: tabWidth, height: bounds.height)
            x += tabWidth
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        let point = touch.location(in: self)
        
        for (idx, tab) in tabViews.enumerated() where tab.frame.contains(point) {
            selectTab(idx: idx)
            break
        }
    }
    
    func selectTab(idx: Int) {
        for tab in tabViews {
            tab.imageView.tintColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
            tab.nameLabel.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        }
        
        tabViews[idx].imageView.tintColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        tabViews[idx].nameLabel.textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        
        selectedTab = idx
        delegate?.updatedSelectedTab(index: idx)
    }
    
    func updateTabs(tabs: [Tab]) {
        for tabView in tabViews {
            tabView.removeFromSuperview()
        }
        
        for tab in tabs {
            let tabView = TabView(tab: tab)
            
            addSubview(tabView)
            tabViews.append(tabView)
        }
        
        selectTab(idx: 0)
    }
}

protocol TabBarViewDelegate {
    func updatedSelectedTab(index: Int)
}
