//
//  QuestionCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 15.07.22.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var showHideAnswerButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var constraintWihtoutAnswer: NSLayoutConstraint!
    @IBOutlet weak var constraintWithAnswer: NSLayoutConstraint!
    @IBOutlet weak var viewWithData: UIView!
    
    var hideAnswer: Bool = true
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        viewWithData.setRoundingToView(cornerRadius: Const.CornerRadiusTo.viewAndImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func showHideAnswerAction(_ sender: UIButton) {
        
//        if hideAnswer {
//            constraintWihtoutAnswer.isActive = false
//            constraintWithAnswer.isActive = true
//            UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseInOut]) {
//                self.answerView.isHidden = false
//            } completion: { finish in
//                self.showHideAnswerButton.imageView?.image = UIImage(systemName: "chevron.up")
//                self.hideAnswer = false
//            }
//        } else {
//
//            constraintWihtoutAnswer.isActive = true
//            constraintWithAnswer.isActive = false
//            UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseInOut]) {
//                self.answerView.isHidden = true
//            } completion: { finish in
//                self.showHideAnswerButton.imageView?.image = UIImage(systemName: "chevron.down")
//                self.hideAnswer = true
//            }
//        }
        
        
//        if hideAnswer {
//            self.showHideAnswerButton.imageView?.image = UIImage(systemName: "chevron.up")
//            constraintWihtoutAnswer.isActive = false
//            constraintWithAnswer.isActive = true
//            UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseInOut]) {
//                self.answerView.isHidden = false
//            } completion: { finish in
//                self.hideAnswer = false
//                self.layoutIfNeeded()
//            }
//        } else {
//            self.showHideAnswerButton.imageView?.image = UIImage(systemName: "chevron.down")
//            constraintWihtoutAnswer.isActive = true
//            constraintWithAnswer.isActive = false
//            UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseInOut]) {
//                self.answerView.isHidden = true
//            } completion: { finish in
//                self.hideAnswer = true
//                self.layoutIfNeeded()
//            }
//        }
        
    }
}
