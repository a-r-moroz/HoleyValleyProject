//
//  PopularQuestionsViewController.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 15.07.22.
//

import UIKit
import Firebase

class PopularQuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var viewForSpinner: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var database: DatabaseReference!
    var questions = [Question]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        spinner.startAnimating()
        viewForSpinner.isHidden = false
        self.view.isUserInteractionEnabled = false
        setupTable()
        loadQuestions()
    }
    
    private func setupTable() {
        
        questionsTable.delegate = self
        questionsTable.dataSource = self
        let nib = UINib(nibName: String(describing: QuestionCell.self), bundle: nil)
        questionsTable.register(nib, forCellReuseIdentifier: String(describing: QuestionCell.self))
        questionsTable.estimatedRowHeight = 100
        questionsTable.rowHeight = UITableView.automaticDimension
    }
    
    private func loadQuestions() {
        
        database = Database.database().reference()
        questions = []
        
        let query = self.database.child(Const.Firebase.questionsPath).queryOrderedByKey()
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let value = child.value as? NSDictionary
                
                let header = value?["header"] as? String ?? ""
                let body = value?["body"] as? String ?? ""
                let item = Question(header: header, body: body)
                self.questions.append(item)
                
                DispatchQueue.main.async {
                    self.questionsTable.reloadData()
                }
            }
            self.spinner.stopAnimating()
            self.viewForSpinner.isHidden = true
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension PopularQuestionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuestionCell.self), for: indexPath)
        guard let questionCell = cell as? QuestionCell else { return cell }
        let item = questions[indexPath.row]
        questionCell.questionLabel.text = item.header
        questionCell.answerLabel.text = item.body
        questionCell.layoutIfNeeded()
        return questionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedAnswerVC = SingleQuestionViewController(nibName: String(describing: SingleQuestionViewController.self), bundle: nil)
        
        if let sheet = selectedAnswerVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.preferredCornerRadius = Const.CornerRadiusTo.sheetController
        }
        
        selectedAnswerVC.currentQuestion = questions[indexPath.row]
        present(selectedAnswerVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
