//
//  EmptyStateView.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/29/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    let picture: UIImageView
    let primaryLabel: UILabel
    let secondaryLabel: UILabel
    
    init(parentView: UIView, image: UIImage, primaryText: String, secondaryText: String) {
        let frame = parentView.frame
        let pictureWidth = frame.width * 0.50
        let remaining = frame.width * 0.50
        picture = UIImageView(frame: CGRect(x: remaining/2, y: 25, width: pictureWidth, height: pictureWidth))
        picture.image = image
        primaryLabel = UILabel()
        primaryLabel.text = primaryText
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 18)
        primaryLabel.sizeToFit()
        primaryLabel.frame.origin = CGPoint(x: parentView.center.x - primaryLabel.frame.width/2, y: 20 + pictureWidth + 10)
        secondaryLabel = UILabel()
        secondaryLabel.text = secondaryText
        secondaryLabel.font = UIFont.systemFont(ofSize: 16)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
        secondaryLabel.textColor = #colorLiteral(red: 0.3364960849, green: 0.3365047574, blue: 0.3365000486, alpha: 1)
        secondaryLabel.frame.origin = CGPoint(x: parentView.center.x - secondaryLabel.frame.width/2, y: primaryLabel.frame.origin.y + primaryLabel.frame.height + 10)
        super.init(frame: frame)
        addSubview(picture)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
