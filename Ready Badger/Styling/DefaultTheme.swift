//
//  DefaultTheme.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/8/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

protocol DefaultTheme {
    func applyTheme()
}

extension DefaultTheme where Self: UIViewController {
    
    func applyTheme() {
        styleNavBar()
        view.tintColor = UIColor.secondaryTint()
    }
    
    func styleNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = UIColor.navigationBar()
        navigationController?.navigationBar.tintColor = UIColor.secondaryTint()
    }
    
}
