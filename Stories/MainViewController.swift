//
//  MainViewController.swift
//  Stories
//
//  Created by Jack Cook on 9/17/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, TabBarViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomBar: TabBarView!
    
    fileprivate var storiesView: UITableView!
    fileprivate var flashcardsView: UIView!
    
    fileprivate var storyToSend: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.delegate = self
        
        let tabs = [Tab(name: "Lessons", image: #imageLiteral(resourceName: "Book")), Tab(name: "Flashcards", image: #imageLiteral(resourceName: "Flashcard"))]
        bottomBar.updateTabs(tabs: tabs)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if storiesView == nil {
            storiesView = UITableView(frame: CGRect.zero, style: .plain)
            storiesView.dataSource = self
            storiesView.delegate = self
            storiesView.separatorStyle = .none
            contentView.addSubview(storiesView)
        }
        storiesView.frame = contentView.bounds
        
        if flashcardsView == nil {
            flashcardsView = UIView()
            flashcardsView.backgroundColor = UIColor.white
            contentView.insertSubview(flashcardsView, belowSubview: storiesView)
        }
        flashcardsView.frame = contentView.bounds
        
        let bottomShadowPath = UIBezierPath(rect: bottomBar.bounds)
        bottomBar.layer.masksToBounds = false
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomBar.layer.shadowOpacity = 0.15
        bottomBar.layer.shadowPath = bottomShadowPath.cgPath
    }
    
    fileprivate func display(stories: Bool) {
        guard let _ = storiesView, let _ = flashcardsView else {
            return
        }
        
        if stories {
            contentView.bringSubview(toFront: storiesView)
        } else {
            contentView.bringSubview(toFront: flashcardsView)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let story = storyToSend else {
            return
        }
        
        if let svc = segue.destination as? StoryViewController {
            svc.story = story
        }
    }
    
    // MARK: TabBarViewDelegate Methods
    
    func updatedSelectedTab(index: Int) {
        display(stories: index == 0)
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Story.stories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StoryCell(story: Story.stories()[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storyToSend = Story.stories()[indexPath.row]
        performSegue(withIdentifier: "storySegue", sender: self)
    }
}
