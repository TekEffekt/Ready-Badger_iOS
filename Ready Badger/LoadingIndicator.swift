//
//  LoadingIndicator.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 12/18/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import MBProgressHUD

class LoadingIndicator {
    
    static var indicator: MBProgressHUD?
    
    static func showIndicator() {
        OperationQueue.main.addOperation {
            guard let base = UIApplication.shared.keyWindow?.rootViewController else { return }
            
            indicator = MBProgressHUD.showAdded(to: base.view, animated: true)
            indicator?.label.text = "Loading.."
            indicator?.isUserInteractionEnabled = false
        }
    }
    
    static func hideIndicator() {
        OperationQueue.main.addOperation {
            indicator?.hide(animated: true)
        }
    }
    
}
