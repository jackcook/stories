//
//  StoriesViewController.swift
//  Stories
//
//  Created by Jack Cook on 9/16/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomBar: TabBarView!
    
    fileprivate var storyToSend: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let tabs = [Tab(name: "Lessons", image: #imageLiteral(resourceName: "Book")), Tab(name: "Flashcards", image: #imageLiteral(resourceName: "Flashcard"))]
        bottomBar.updateTabs(tabs: tabs)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomShadowPath = UIBezierPath(rect: bottomBar.bounds)
        bottomBar.layer.masksToBounds = false
        bottomBar.layer.shadowColor = UIColor.black.cgColor
        bottomBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        bottomBar.layer.shadowOpacity = 0.15
        bottomBar.layer.shadowPath = bottomShadowPath.cgPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let story = storyToSend else {
            return
        }
        
        if let svc = segue.destination as? StoryViewController {
            svc.story = story
        }
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
