//
//  EditListItemController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/4/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class EditListController: FormTableViewController, DefaultTheme {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var list: ReadyList?
    var isNew: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if list == nil {
            list = ReadyList()
            navigationItem.title = "Create List"
            isNew = true
            saveButton.title = "Done"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        setupTextFields()
    }
    
    func setupTextFields() {
        if list!.name.characters.count > 0 {
            titleLabel.text = list!.name
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string)
        if titleLabel === textField {
            list?.name = newString
        }
        
        return true
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        ListItemWrites.add(list: list!)
        if isNew {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
