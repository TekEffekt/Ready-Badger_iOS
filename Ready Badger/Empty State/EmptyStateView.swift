//
//  EmptyStateView.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/29/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

enum EmptyStateType {
    case alert, resources, makeAList, listItem
}

class EmptyStateView: UIView {
    
    let picture: UIImageView
    let primaryLabel: UILabel
    let secondaryLabel: UILabel
    
    init(parentView: UIView, image: UIImage, primaryText: String, secondaryText: String) {
        let frame = parentView.frame
        let pictureWidth = frame.width * 0.4
        let remaining = frame.width * 0.60
        picture = UIImageView(frame: CGRect(x: remaining/2, y: 25, width: pictureWidth, height: pictureWidth))
        picture.image = image
        primaryLabel = UILabel()
        primaryLabel.text = primaryText
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 18)
        primaryLabel.sizeToFit()
        primaryLabel.frame.origin = CGPoint(x: parentView.center.x - primaryLabel.frame.width/2, y: 20 + pictureWidth + 10)
        secondaryLabel = UILabel()
        secondaryLabel.text = secondaryText
        secondaryLabel.font = UIFont.systemFont(ofSize: 15)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.frame = CGRect(x: 0, y: 0, width: frame.width * 0.70, height: 40)
        secondaryLabel.frame.origin = CGPoint(x: parentView.center.x - secondaryLabel.frame.width/2, y: primaryLabel.frame.origin.y + primaryLabel.frame.height + 10)
        secondaryLabel.textAlignment = .center
        secondaryLabel.textColor = #colorLiteral(red: 0.3364960849, green: 0.3365047574, blue: 0.3365000486, alpha: 1)
        super.init(frame: frame)
        addSubview(picture)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class AlertEmptyStateView: EmptyStateView {
    
    init(inParentView parentView: UIView) {
        super.init(parentView: parentView, image: #imageLiteral(resourceName: "Empty State"), primaryText: "No County Data", secondaryText: "Hit the settings button to subscribe to a county.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ResourcesEmptyStateView: EmptyStateView {
    
    init(inParentView parentView: UIView) {
        super.init(parentView: parentView, image: #imageLiteral(resourceName: "Empty State"), primaryText: "No Disaster Resources", secondaryText: "Subscribe to a county to get disaster resources for that county.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MakeAListEmptyStateView: EmptyStateView {
    
    init(inParentView parentView: UIView) {
        super.init(parentView: parentView, image: #imageLiteral(resourceName: "Empty State"), primaryText: "No Lists", secondaryText: "Hit the plus button to create a list.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ListItemEmptyStateView: EmptyStateView {
    
    init(inParentView parentView: UIView) {
        super.init(parentView: parentView, image: #imageLiteral(resourceName: "Empty State"), primaryText: "No List Items", secondaryText: "Hit the plus button to create an item.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
