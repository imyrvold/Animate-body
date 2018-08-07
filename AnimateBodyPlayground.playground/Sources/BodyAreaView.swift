
//
//  BodyAreaView.swift
//  RegIT
//
//  Created by Ivan C Myrvold on 22.07.2018.
//  Copyright © 2018 Better. All rights reserved.
//

import UIKit

public class BodyAreaView: UIView {
    var ringColor: UIColor = .black
    
    lazy var ringLayer: CAShapeLayer = {
        let ringLayer = CAShapeLayer()
        let ringPath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 4, dy: 4))
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = UIColor.black.cgColor
        ringLayer.path = ringPath.cgPath
        ringLayer.name = "ring"
        ringLayer.needsDisplayOnBoundsChange = true
        
        return ringLayer
    }()
    
    override public func draw(_ rect: CGRect) {
        self.layer.addSublayer(self.ringLayer)
    }
    
    override public func layoutSubviews() {
        guard let sublayers = self.layer.sublayers else { return }
        for layer in sublayers {
            layer.frame = layer.bounds
        }
    }
    
}
