//
//  ExerciseView.swift
//  Stories
//
//  Created by Jack Cook on 9/18/16.
//  Copyright © 2016 Jack Cook. All rights reserved.
//

import SVProgressHUD
import UIKit

class ExerciseView: UIView, UITextFieldDelegate {
    
    static let nextExercise = Notification.Name("nextExercise")
    
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
        let correct = answerField.text ?? "" == answer
        
        DispatchQueue.main.async {
            if correct {
                NotificationCenter.default.post(name: ExerciseView.nextExercise, object: self.tag)
            } else {
                SVProgressHUD.showError(withStatus: "Incorrect")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    SVProgressHUD.dismiss()
                }
            }
        }
        
        return true
    }
}
