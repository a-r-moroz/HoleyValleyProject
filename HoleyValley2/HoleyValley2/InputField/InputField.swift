//
//  InputField.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 7.06.22.
//

import UIKit

@IBDesignable class InputField: UIView {
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    //    private var internalPlaceholder: String?
    
    // @IBInspectable - добавляет свойство в
    @IBInspectable var placeholder: String? {
        get { return placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }
    
    @IBInspectable var error: String? {
        get { return errorLabel.text }
        set { errorLabel.text = newValue }
    }
    
    //
    var validationType: ValidationType = .none
    private var timer: Timer?
    
    // валидно, если все поля заполнены
    var isValid: Bool {
        
        guard validationType != .none else { return true }
        guard let text = textField.text else { return false }
        let passPred = NSPredicate(format: "SELF MATCHES %@", self.validationType.rawValue)
        errorLabel.isHidden = passPred.evaluate(with: text)
        return passPred.evaluate(with: text)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        
        let bundle = Bundle(for: InputField.self)
        bundle.loadNibNamed(String(describing: InputField.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        placeholderLabel.isHidden = placeholderLabel.text == nil && placeholderLabel.text == ""
        errorLabel.isHidden = true
        //        errorLabel.isHidden = errorLabel.text == nil && errorLabel.text == ""
        
        textField.addTarget(self, action: #selector(validateText), for: .allEvents)
        
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.textField.leftView = paddingView
        self.textField.leftViewMode = .always
        
    }
    
    @objc private func validateText() {
        
        timer?.invalidate()
        
        guard validationType != .none else {
            
            errorLabel.isHidden = true
            return
        }
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            errorLabel.isHidden = true
            return
        }
        
        //        errorLabel.isHidden = text.isEmpty
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            let passPred = NSPredicate(format: "SELF MATCHES %@", self.validationType.rawValue)
            //            self.errorLabel.isHidden = passPred.evaluate(with: text)
            passPred.evaluate(with: text) ? self.validationSuccess() : self.validationFailure()
            
        })
    }
    
    private func validationSuccess() {
        
        self.errorLabel.isHidden = true
    }
    
    private func validationFailure() {
        
        self.errorLabel.isHidden = false
        UIView.animate(withDuration: 1) { [weak self] in
            self?.textField.shake()
            self?.textField.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.8).cgColor
            
        } completion: { [weak self] isFinished in
            if isFinished {
                //                self?.contentView.backgroundColor = .clear
                
                UIView.animate(withDuration: 0.5) {
                    
                    self?.textField.layer.borderColor = UIColor.systemGray5.cgColor
                }
                
            }
        }
        
        /*
         UIView.animate(withDuration: 1) { [weak self] in
         self?.contentView.backgroundColor = .red
         } completion: { [weak self] isFinished in
         if isFinished {
         self?.contentView.backgroundColor = .clear
         }
         }
         */
        
    }
}
