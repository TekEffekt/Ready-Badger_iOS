//
//  CalloutView.swift
//  SwiftMapViewCustomCallout
//
//  Created by Robert Ryan on 6/15/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//
//  This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
//  http://creativecommons.org/licenses/by-sa/4.0/

import UIKit

@IBDesignable public class BubbleView: UIView {

    @IBInspectable public var cornerRadius      : CGFloat = 5
    @IBInspectable public var arrowHeight       : CGFloat = 5
    @IBInspectable public var arrowAngle        : CGFloat = CGFloat(M_PI_4)
    @IBInspectable public var bubbleFillColor   : UIColor = UIColor.white
    @IBInspectable public var bubbleStrokeColor : UIColor = UIColor.white
    @IBInspectable public var bubbleLineWidth   : CGFloat = 1
    
    public let contentView = UIView()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configure()
    }

    private func configure() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        addSubview(contentView)
    }

    override public func layoutSubviews() {
        let contentViewFrame = CGRect(x: cornerRadius, y: cornerRadius, width: frame.size.width - cornerRadius * 2.0, height: frame.size.height - cornerRadius * 2.0 - arrowHeight)
        
        contentView.frame = contentViewFrame
    }
    
    public func setContentViewSize(size: CGSize) {
        var bubbleFrame = self.frame
        bubbleFrame.size = CGSize(width: size.width + cornerRadius * 2.0, height: size.height + cornerRadius * 2.0 + arrowHeight)
        frame = bubbleFrame
        setNeedsDisplay()
    }
    
    // draw the callout/popover/bubble with rounded corners and an arrow pointing down (presumably to the item below this)
    
    override public func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let start = CGPoint(x: frame.size.width / 2.0, y: frame.size.height)
        
        path.move(to: start)
        
        // right side of arrow
        
        var point = CGPoint(x: start.x + CGFloat(arrowHeight * tan(arrowAngle)), y: start.y - arrowHeight - bubbleLineWidth)
        path.addLine(to: point)
        
        // lower right
        
        point.x = frame.size.width - cornerRadius - bubbleLineWidth / 2.0
        path.addLine(to: point)
        
        // lower right corner
        
        point.x += cornerRadius
        var controlPoint = point
        point.y -= cornerRadius
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // right
        
        point.y -= frame.size.height - arrowHeight - cornerRadius * CGFloat(2.0) - bubbleLineWidth * CGFloat(1.5)
        path.addLine(to: point)
        
        // upper right corner
        
        point.y -= cornerRadius
        controlPoint = point
        point.x -= cornerRadius
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // top
        
        point.x -= (frame.size.width - cornerRadius * 2.0 - bubbleLineWidth)
        path.addLine(to: point)
        
        var lowerLeftPoint = point
        lowerLeftPoint.y += cornerRadius
        
        // top left corner
        
        point.x -= cornerRadius
        controlPoint = point
        point.y += cornerRadius
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // left
        
        point.y += frame.size.height - arrowHeight - cornerRadius * CGFloat(2.0) - bubbleLineWidth * CGFloat(1.5)
        path.addLine(to: point)
        
        // lower left corner
        
        point.y += cornerRadius
        controlPoint = point
        point.x += cornerRadius
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // lower left
        
        point = CGPoint(x: start.x - CGFloat(arrowHeight * tan(arrowAngle)), y: start.y - arrowHeight - bubbleLineWidth)
        path.addLine(to: point)
        
        // left side of arrow
        
        path.close()
        
        // draw the callout bubble
        
        bubbleFillColor.setFill()
        bubbleStrokeColor.setStroke()
        path.lineWidth = bubbleLineWidth
        
        path.fill()
        path.stroke()
    }

}
