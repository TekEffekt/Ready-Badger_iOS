//
//  FormTableViewController.swift
//  Safety Survey
//
//  Created by Kyle Zawacki on 8/24/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class FormTableViewController: UITableViewController, UITextFieldDelegate {
    // MARK: Properties
    var amountMoved: CGFloat = 0
    var currentTextField: UITextField?
    var optionList:[String] = []
    var chosenOptions:[String] = []
    var optionIsMulti = true
    var chosenOptionId: String?
    var dontAdjust = false
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToKeyBoardNotifications()
    }
    
    private func subscribeToKeyBoardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldPressed(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldHiding(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Text Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
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
    
    // MARK: Deinit
    override func viewWillDisappear(_ animated: Bool) {
        currentTextField?.resignFirstResponder()
    }

}
