//
//  EditListItemController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class EditListItemController: FormTableViewController, DefaultTheme {

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var listItem: ListItem?
    var list: ReadyList!
    var isNew: Bool = false
    var descriptionEmpty = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listItem == nil {
            listItem = ListItem()
            navigationItem.title = "Create Item"
            isNew = true
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        setupTextFields()
        if !isNew {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func setupTextFields() {
        if listItem!.name.characters.count > 0 {
            titleLabel.text = listItem!.name
        }
        if listItem!.itemDescription.characters.count > 0 {
            descriptionTextView.text = listItem!.itemDescription
            descriptionEmpty = false
            descriptionTextView.textColor = .black
        } else {
            descriptionTextView.textColor = .lightGray
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string)
        if titleLabel === textField {
            ListItemWrites.update(item: listItem!, withName: newString)
        }
        return true
    }
    
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let userEnteredString = textView.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: text)
        if descriptionTextView === textView {
            updateDescription(withString: text, andNewString: newString)
        }
        return true
    }
    
    private func updateDescription(withString string: String, andNewString newString: String) {
        if descriptionEmpty {
            descriptionTextView.text = string
            descriptionEmpty = false
            ListItemWrites.update(item: listItem!, withDescription: "")
            descriptionTextView.textColor = .black
        } else {
            if newString.characters.count == 0 {
                descriptionTextView.text = "Description goes here..."
                descriptionTextView.textColor = .lightGray
                descriptionEmpty = true
                ListItemWrites.update(item: listItem!, withDescription: "")
            } else {
                ListItemWrites.update(item: listItem!, withDescription: newString)
            }
        }
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if isNew {
            ListItemWrites.add(listItem: listItem!, inList: list)
            dismiss(animated: true, completion: nil)
        }
    }

}
