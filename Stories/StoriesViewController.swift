//
//  StoriesViewController.swift
//  Stories
//
//  Created by Jack Cook on 9/16/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if tableView == nil {
            tableView = UITableView()
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            view.addSubview(tableView)
        }
        tableView.frame = CGRect(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height - 20)
    }
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StoryCell(story: Story.getFirstStory())
        return cell
    }
    
    // MARK: UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "storySegue", sender: self)
    }
}
