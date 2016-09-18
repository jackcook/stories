//
//  ExercisesView.swift
//  Stories
//
//  Created by Jack Cook on 9/18/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import SVProgressHUD
import UIKit

class ExercisesView: UIView {
    
    static let finishedExercises = Notification.Name("finishedExercises")
    
    var exercises: [(String, String, String)]!
    
    fileprivate var scrollView: UIScrollView!
    
    init() {
        super.init(frame: CGRect.zero)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nextExercise(notification:)), name: ExerciseView.nextExercise, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if scrollView == nil {
            scrollView = UIScrollView()
            addSubview(scrollView)
            
            for exercise in exercises {
                let exerciseView = Bundle.main.loadNibNamed("ExerciseView", owner: self, options: nil)![0] as! ExerciseView
                exerciseView.question = exercise.0
                exerciseView.placeholder = exercise.1
                exerciseView.answer = exercise.2
                addSubview(exerciseView)
            }
        }
        scrollView.frame = bounds
        
        var totalHeight: CGFloat = 0
        
        for view in scrollView.subviews where view is ExerciseView {
            let textView = (view as! ExerciseView).questionTextView!
            let height = textView.sizeThatFits(CGSize(width: bounds.width - 144, height: CGFloat.greatestFiniteMagnitude)).height
            
            view.frame = CGRect(x: 0, y: totalHeight, width: bounds.width, height: height)
            totalHeight += view.bounds.height
        }
    }
    
    override func addSubview(_ view: UIView) {
        if view is ExerciseView {
            view.frame = CGRect(x: 0, y: 0, width: 1, height: 72)
            view.tag = scrollView.subviews.count
            scrollView.addSubview(view)
        } else {
            super.addSubview(view)
        }
    }
    
    @objc fileprivate func nextExercise(notification: Notification) {
        var next = false
        
        for view in scrollView.subviews where view is ExerciseView {
            if next {
                (view as? ExerciseView)?.answerField.becomeFirstResponder()
                next = false
                break
            }
            
            if view.tag == notification.object as? Int {
                next = true
            }
        }
        
        if next {
            NotificationCenter.default.post(name: ExercisesView.finishedExercises, object: nil)
        } else {
            SVProgressHUD.showSuccess(withStatus: "Correct")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SVProgressHUD.dismiss()
            }
        }
    }
}
