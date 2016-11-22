//
//  CalloutAnnotationView.swift
//  SwiftMapViewCustomCallout
//
//  Created by Robert Ryan on 6/15/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//
//  This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
//  http://creativecommons.org/licenses/by-sa/4.0/

import UIKit
import MapKit

class CalloutAnnotationView : MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // if we (re)set the annotation, remove old observer for title, if any and add new one
    override var annotation: MKAnnotation? {
        willSet {
            if let calloutAnnotation = annotation as? CalloutAnnotation {
                calloutAnnotation.underlyingAnnotation.removeObserver(self, forKeyPath: "title")
            }
        }
        didSet {
            updateCallout()
            if let calloutAnnotation = annotation as? CalloutAnnotation {
                calloutAnnotation.underlyingAnnotation.addObserver(self, forKeyPath: "title", options: [], context: nil)
            }
        }
    }

    // if this gets deallocated, remove any observer of the title
    deinit {
        if let calloutAnnotation = annotation as? CalloutAnnotation {
            calloutAnnotation.underlyingAnnotation.removeObserver(self, forKeyPath: "title")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateCallout()
    }
    
    let bubbleView = BubbleView()           // the view that actually represents the callout bubble
    var label = UILabel()                   // the label we'll add as subview to the bubble's contentView
    var imageView = UIImageView()
    let font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    var title = ""
    var size : CGSize?
    
    /// Perform the initial configuration of the subviews
    
    func configure() {
        backgroundColor = UIColor.clear
        
        addSubview(bubbleView)
        
        size = CGSize()
        size!.width = UIScreen.main.bounds.maxX * 0.8
        size!.height = size!.width * 0.93
        
        label.frame = CGRect(x: 0, y: 0, width: size!.width, height: 30)
        imageView.frame = CGRect(x: 0, y: 35, width: size!.width, height: size!.height - 35)
        
        label.textAlignment = .center
        label.font = font
        
        bubbleView.contentView.addSubview(label)
        bubbleView.contentView.addSubview(imageView)
        
        updateCallout()
    }
    
    /// Update size and layout of callout view
    func updateCallout() {
        if annotation == nil {
            return
        }
        
        if let annotation = annotation as? CalloutAnnotation {
            
            if let title = annotation.title {
                label.text = title
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                label.preferredMaxLayoutWidth = 150
            }
            if let graphURLString = annotation.graphURLString {
                imageView.downloadedFrom(link: graphURLString)
                imageView.contentMode = .scaleAspectFit
            }
        }
        
        if size == nil {
            size = CGSize()
            size!.width = UIScreen.main.bounds.maxX * 0.8
            size!.height = size!.width * 0.93
        }
        
        bubbleView.setContentViewSize(size: size!)
        frame = bubbleView.bounds
        centerOffset = CGPoint(x: 0, y: -(size!.height / 2 + 25))
    }
}

