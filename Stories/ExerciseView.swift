//
//  ExerciseView.swift
//  Stories
//
//  Created by Jack Cook on 9/18/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import UIKit

class ExerciseView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerField: UITextField!
    
    var question: String! {
        didSet {
            questionTextView.text = question
        }
    }
    
    var placeholder: String! {
        didSet {
            answerField.placeholder = placeholder
        }
    }
    
    var answer: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        answerField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\(answerField.text! == answer ? "" : "in")correct")
        return true
    }
}
