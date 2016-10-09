//
//  CountySettingsViewController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class CountySettingsViewController: UIViewController, DefaultTheme, UITableViewDataSource {

    @IBOutlet weak var countyTable: UITableView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countyTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        setupToolbar()
    }
    
    private func setupToolbar() {
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let showSelectedButton = UIBarButtonItem(title: "Show Selected", style: .plain, target: self, action: #selector(self.showSelected))
        toolbar.items = [leftSpace, showSelectedButton, rightSpace]
        showSelectedButton.tintColor = UIColor.tint()
    }
    
    func showSelected() {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "County Cell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "North"
    }

}
