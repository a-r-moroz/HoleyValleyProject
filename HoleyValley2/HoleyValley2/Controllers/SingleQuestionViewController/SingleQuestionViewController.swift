//
//  SingleQuestionViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 15.07.22.
//

import UIKit

class SingleQuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var currentQuestion: Question?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let question = currentQuestion else { return }
        questionLabel.text = question.header
        answerLabel.text = question.body
    }
}
