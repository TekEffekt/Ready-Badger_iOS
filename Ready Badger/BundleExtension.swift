//
//  NSBundleExtension.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/14/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import Foundation

extension Bundle {
    
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        
        fatalError("Could not load view with type " + String(describing: type))
    }
    
}
