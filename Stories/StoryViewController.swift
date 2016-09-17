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
        
        for view in storyViews {
            container.addSubview(view)
        }
        
        pageControl.numberOfPages = 3
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
