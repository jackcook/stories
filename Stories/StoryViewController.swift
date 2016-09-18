//
//  StoryViewController.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var container: UIScrollView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var story: Story!
    
    fileprivate var storyViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.delegate = self
        
        for part in story.parts {
            if let part = part as? StoryReading {
                let textView = Bundle.main.loadNibNamed("StoryTextView", owner: self, options: nil)![0] as! StoryTextView
                textView.reading = part
                storyViews.append(textView)
            } else if let part = part as? StoryLesson {
                let lessonView = Bundle.main.loadNibNamed("StoryLessonView", owner: self, options: nil)![0] as! StoryLessonView
                lessonView.fileName = part.fileName
                storyViews.append(lessonView)
            } else if let part = part as? StoryExercises {
                let exercisesView = ExercisesView()
                exercisesView.exercises = ["test1": "test2"]
                storyViews.append(exercisesView)
            }
        }
        
        for (idx, view) in storyViews.enumerated() {
            container.addSubview(view)
            view.frame = CGRect(x: container.bounds.width * CGFloat(idx), y: 0, width: container.bounds.width, height: container.bounds.height)
        }
        
        pageControl.numberOfPages = storyViews.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let shadowPath = UIBezierPath(rect: bottomBar.bounds)
        bottomBar.layer.masksToBounds = false
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomBar.layer.shadowOpacity = 0.15
        bottomBar.layer.shadowPath = shadowPath.cgPath
        
        for (idx, view) in storyViews.enumerated() {
            view.frame = CGRect(x: container.bounds.width * CGFloat(idx), y: 0, width: container.bounds.width, height: container.bounds.height)
        }
        
        container.contentSize = CGSize(width: container.bounds.width * CGFloat(pageControl.numberOfPages), height: container.bounds.height)
    }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pageControlUpdated(sender: UIPageControl) {
        let frame = CGRect(x: container.bounds.width * CGFloat(pageControl.currentPage), y: 0, width: container.bounds.width, height: container.bounds.height)
        container.scrollRectToVisible(frame, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        pageControl.currentPage = Int(page)
    }
}
