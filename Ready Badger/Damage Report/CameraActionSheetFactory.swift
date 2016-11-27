//
//  CameraActionSheet.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/26/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation
import UIKit

class CameraActionSheetFactory {
    
    static func create(cameraAction: @escaping ((UIAlertAction) -> Void), libraryAction: @escaping ((UIAlertAction) -> Void), removeAction: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default, handler: cameraAction)
        let libraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: libraryAction)
        let removeAction = UIAlertAction(title: "Remove Current Photo", style: .destructive, handler: removeAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cameraAction)
        sheet.addAction(libraryAction)
        sheet.addAction(removeAction)
        sheet.addAction(cancelAction)
        return sheet
    }
    
}
