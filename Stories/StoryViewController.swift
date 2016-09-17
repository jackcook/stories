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
    
    fileprivate var storyViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container.delegate = self
        
        let textView = Bundle.main.loadNibNamed("StoryTextView", owner: self, options: nil)![0] as! StoryTextView
        storyViews.append(textView)
        
        let lessonView = Bundle.main.loadNibNamed("StoryLessonView", owner: self, options: nil)![0] as! StoryLessonView
        storyViews.append(lessonView)
        
        for (idx, view) in storyViews.enumerated() {
            container.addSubview(view)
            view.frame = CGRect(x: container.bounds.width * CGFloat(idx), y: 0, width: container.bounds.width, height: container.bounds.height)
        }
        
        pageControl.numberOfPages = storyViews.count
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let shadowPath = UIBezierPath(rect: bottomBar.bounds).cgPath
        bottomBar.layer.masksToBounds = false
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        bottomBar.layer.shadowOpacity = 0.15
        bottomBar.layer.shadowPath = shadowPath
        
        for (idx, view) in storyViews.enumerated() {
            view.frame = CGRect(x: container.bounds.width * CGFloat(idx), y: 0, width: container.bounds.width, height: container.bounds.height)
        }
        
        container.contentSize = CGSize(width: container.bounds.width * CGFloat(pageControl.numberOfPages), height: container.bounds.height)
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
