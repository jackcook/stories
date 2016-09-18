//
//  StoryCell.swift
//  Stories
//
//  Created by Jack Cook on 9/16/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {
    
    fileprivate var story: Story!
    
    fileprivate var container: UIView!
    fileprivate var thumbnailImage: UIImageView!
    fileprivate var bottomContainer: UIView!
    fileprivate var nameLabel: UILabel!
    fileprivate var subtitleLabel: UILabel!
    fileprivate var nextArrow: UIImageView!
    
    init(story: Story) {
        self.story = story
        
        super.init(style: .default, reuseIdentifier: "StoryCell")
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if container == nil {
            container = UIView()
            container.backgroundColor = story.backgroundColor
            container.clipsToBounds = true
            container.layer.borderColor = story.darkerColor.cgColor
            container.layer.borderWidth = 2
            container.layer.cornerRadius = 12
            addSubview(container)
        }
        container.frame = CGRect(x: 32, y: 16, width: bounds.width - 64, height: bounds.height - 32)
        
        if thumbnailImage == nil {
            thumbnailImage = UIImageView(image: story.thumbnail)
            thumbnailImage.contentMode = .scaleAspectFit
            container.addSubview(thumbnailImage)
        }
        thumbnailImage.frame = CGRect(x: 0, y: 0, width: container.bounds.width, height: container.bounds.height * (2/3))
        
        if bottomContainer == nil {
            bottomContainer = UIView()
            bottomContainer.backgroundColor = story.darkerColor
            container.addSubview(bottomContainer)
        }
        bottomContainer.frame = CGRect(x: 0, y: container.bounds.height * (2/3), width: container.bounds.width, height: container.bounds.height * (1/3))
        
        if nameLabel == nil {
            nameLabel = UILabel()
            nameLabel.font = UIFont.systemFont(ofSize: 28)
            nameLabel.text = story.name
            nameLabel.textColor = UIColor.white
            bottomContainer.addSubview(nameLabel)
        }
        
        if subtitleLabel == nil {
            subtitleLabel = UILabel()
            subtitleLabel.font = UIFont.systemFont(ofSize: 18)
            subtitleLabel.text = story.topics
            subtitleLabel.textColor = UIColor.white
            bottomContainer.addSubview(subtitleLabel)
        }
        
        nameLabel.sizeToFit()
        subtitleLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 16, y: (bottomContainer.bounds.height - (nameLabel.bounds.height + subtitleLabel.bounds.height)) / 2, width: nameLabel.bounds.width, height: nameLabel.bounds.height)
        subtitleLabel.frame = CGRect(x: 16, y: nameLabel.frame.origin.y + nameLabel.bounds.height, width: subtitleLabel.bounds.width, height: subtitleLabel.bounds.height)
        
        if nextArrow == nil {
            nextArrow = UIImageView()
            nextArrow.image = #imageLiteral(resourceName: "Arrow").withRenderingMode(.alwaysTemplate)
            nextArrow.tintColor = UIColor.white
            bottomContainer.addSubview(nextArrow)
        }
        let nextArrowSpacing: CGFloat = 28
        let nextArrowHeight = bottomContainer.bounds.height - nextArrowSpacing * 2
        nextArrow.frame = CGRect(x: bottomContainer.bounds.width - nextArrowHeight - 16, y: nextArrowSpacing, width: nextArrowHeight, height: nextArrowHeight)
    }
}
