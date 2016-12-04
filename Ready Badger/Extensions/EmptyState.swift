//
//  EmptyState.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/3/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

protocol EmptyState: class {
    func setupEmptyState(withPrimaryText primaryText: String, andSecondaryText secondaryText: String)
    var emptyState: EmptyStateView! { get set }
}

extension EmptyState where Self: UIViewController {
    
    func setupEmptyState(withPrimaryText primaryText: String, andSecondaryText secondaryText: String) {
        emptyState = EmptyStateView(parentView: view, image: #imageLiteral(resourceName: "Empty State"), primaryText: primaryText, secondaryText: secondaryText)
        view.addSubview(emptyState)
    }
    
}
