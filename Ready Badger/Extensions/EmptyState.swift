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
    func configureEmptyState(ofType type: EmptyStateType, hidden: Bool)
    var emptyState: EmptyStateView? { get set }
    func checkIfEmpty()
}

extension EmptyState where Self: UIViewController {
    
    func configureEmptyState(ofType type: EmptyStateType, hidden: Bool) {
        emptyState?.removeFromSuperview()
        switch type {
        case .alert:
            emptyState = AlertEmptyStateView(inParentView: view)
        case .resources:
            emptyState = ResourcesEmptyStateView(inParentView: view)
        case .makeAList:
            emptyState = MakeAListEmptyStateView(inParentView: view)
        }
        view.addSubview(emptyState!)
        
        emptyState!.isHidden = hidden
    }
    
}
