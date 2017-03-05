//
//  ReportAlert.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 3/4/17.
//  Copyright © 2017 App Factory. All rights reserved.
//

import Foundation
import UIKit

class ReportAlert {
    
    static func show() {
        OperationQueue.main.addOperation {
            guard let base = UIApplication.shared.keyWindow?.rootViewController else { return }
            
            let controller = UIAlertController(title: "Success!", message: "Your damage report was sent successfully.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default , handler: nil)
            controller.addAction(okAction)
            base.present(controller, animated: true, completion: nil)
        }
    }
    
}
