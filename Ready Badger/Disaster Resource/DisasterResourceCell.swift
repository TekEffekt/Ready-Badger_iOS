//
//  DisasterResourceCell.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 11/13/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DisasterResourceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapButton: UIView!
    @IBOutlet weak var callButton: UIView!
    var disasterResource: DisasterResource!
    var mapTap: UITapGestureRecognizer!
    var callTap: UITapGestureRecognizer!
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        mapTap = UITapGestureRecognizer(target: self, action: #selector(self.mapTapped))
        callTap = UITapGestureRecognizer(target: self, action: #selector(self.callTapped))
        mapButton.addGestureRecognizer(mapTap)
        callButton.addGestureRecognizer(callTap)
    }
    
    func mapTapped() {
        print("Map tapped")
    }
    
    func callTapped() {
        print("Call tapped")
    }

}
