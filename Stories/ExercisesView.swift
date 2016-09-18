//
//  ExercisesView.swift
//  Stories
//
//  Created by Jack Cook on 9/18/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class ExercisesView: UIView {
    
    var exercises: [String: Any]!
    
    fileprivate var scrollView: UIScrollView!
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if scrollView == nil {
            scrollView = UIScrollView()
            scrollView.backgroundColor = UIColor.red
            addSubview(scrollView)
            
            let exerciseView = Bundle.main.loadNibNamed("ExerciseView", owner: self, options: nil)![0] as! ExerciseView
            addSubview(exerciseView)
        }
        scrollView.frame = bounds
        
        var totalHeight: CGFloat = 0
        
        for view in scrollView.subviews where view is ExerciseView {
            view.frame = CGRect(x: 0, y: totalHeight, width: bounds.width, height: 144)
            totalHeight += view.bounds.height
        }
    }
    
    override func addSubview(_ view: UIView) {
        if view is ExerciseView {
            view.backgroundColor = UIColor.blue
            view.frame = CGRect(x: 0, y: 0, width: 1, height: 72)
            view.tag = scrollView.subviews.count
            scrollView.addSubview(view)
        } else {
            super.addSubview(view)
        }
    }
}
