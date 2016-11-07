//
//  DescriptionViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/6/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var descriptionTextView: UITextView!
    var amountMoved: CGFloat = 0
    var dontAdjust = false
    var descriptionString: String?
    var completionHandler: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToKeyBoardNotifications()
    }
    
    private func subscribeToKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldPressed(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldHiding(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descriptionTextView.text = descriptionString ?? ""
        descriptionTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descriptionTextView.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let handler = completionHandler {
            handler(descriptionTextView.text == "" ? nil : descriptionTextView.text)
        }
        descriptionTextView.resignFirstResponder()
    }
    
    // MARK: Textfield Notifications
    func textFieldPressed(sender: NSNotification) {
        let userInfo = sender.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameBeginUserInfoKey]! as AnyObject).cgRectValue
        let keyboardHeight = keyboardRect?.height
        
        if amountMoved == 0 {
            amountMoved = keyboardHeight!
            
            if !dontAdjust {
                adjustForTextField(withKeyboardHeight: keyboardHeight!)
            }
        }
    }
    
    func textFieldHiding(sender: NSNotification) {
        if !dontAdjust {
            unadjustForTextField()
        }
    }
    
    func adjustForTextField(withKeyboardHeight keyboardHeight: CGFloat) {
        
        UIView.animate(withDuration: 0.3) { [unowned self] () -> Void in
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height - keyboardHeight)
        }
    }
    
    func unadjustForTextField() {
        UIView.animate(withDuration: 0.3) { [unowned self] () -> Void in
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height + self.amountMoved)
        }
        
        amountMoved = 0
    }
    
}
