
//
//  BodyAreaView.swift
//  RegIT
//
//  Created by Ivan C Myrvold on 22.07.2018.
//  Copyright © 2018 Better. All rights reserved.
//

import UIKit

@IBDesignable
public class BodyAreaView: UIView {
    @IBInspectable var mainColor: UIColor = .clear
    @IBInspectable var outsideColor: UIColor = .clear
    @IBInspectable var outsideColorOpacity: Float = 0
    @IBInspectable var ringColor: UIColor = .black
    @IBInspectable var ringThickness: CGFloat = 1
    @IBInspectable var isSelected = true
    
    weak var label: UILabel?
    
    let pulseColor = UIColor(red: 97/255.0, green: 138/255.0, blue: 152/255.0, alpha: 1)
    let pinkColor = UIColor(red: 204/255.0, green: 101/255.0, blue: 157/255.0, alpha: 0.7)
    var isAnimating = false
    lazy var ringLayer: CAShapeLayer = {
        let ringLayer = CAShapeLayer()
        let ringPath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 4, dy: 4))
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = UIColor.black.cgColor
        ringLayer.path = ringPath.cgPath
        ringLayer.name = "ring"
        
        return ringLayer
    }()
    lazy var fillLayer: CAShapeLayer = {
        let fillLayer = CAShapeLayer()
        let bodyAreaPath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 4, dy: 4))
        fillLayer.fillColor = self.pulseColor.cgColor
        fillLayer.path = bodyAreaPath.cgPath
        fillLayer.name = "inner"
        
        return fillLayer
    }()
    lazy var outerLayer: CAShapeLayer = {
        let outerLayer = CAShapeLayer()
        let outerPath = UIBezierPath(ovalIn: self.bounds)
        outerLayer.fillColor = self.pinkColor.cgColor
        outerLayer.strokeColor = pinkColor.cgColor
        outerLayer.lineWidth = 6
        outerLayer.path = outerPath.cgPath
        outerLayer.name = "outer"
        
        return outerLayer
    }()
    lazy var pulseAnimation: CABasicAnimation = {
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = 0.7
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = 0
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        
        return pulseAnimation
    }()
    
    
    override public func draw(_ rect: CGRect) {
        let fillLayer = CAShapeLayer()
        let bodyAreaPath = UIBezierPath(ovalIn: rect)
        fillLayer.fillColor = self.mainColor.cgColor
        fillLayer.path = bodyAreaPath.cgPath
        fillLayer.name = "inner"
        
        
        
        self.layer.addSublayer(fillLayer)
        self.layer.addSublayer(self.ringLayer)
        
        
    }
    
    func gradeColor(for grade: Int) -> UIColor {
        let gradeColor: UIColor
        if grade == 1 {
            gradeColor = self.pinkColor.withAlphaComponent(0.2)
        } else if grade == 2 {
            gradeColor = self.pinkColor.withAlphaComponent(0.35)
        } else if grade == 3 {
            gradeColor = self.pinkColor.withAlphaComponent(0.5)
        } else if grade == 4 {
            gradeColor = self.pinkColor.withAlphaComponent(0.65)
        } else if grade == 5 {
            gradeColor = self.pinkColor.withAlphaComponent(0.8)
        } else {
            gradeColor = self.pinkColor.withAlphaComponent(1)
        }
        return gradeColor
    }
    
    func doAnimate(with grade: Int = 0) {
        self.start(self.pulseAnimation, with: grade)
    }
    
    func continueAnimate(with grade: Int = 0) {
        self.isAnimating = false
        self.start(self.pulseAnimation, with: grade)
    }
    
    
    func start(_ animation: CABasicAnimation, with grade: Int = 0) {
        self.layer.sublayers = nil
        if self.isAnimating {
            self.isAnimating = false
            self.layer.addSublayer(self.ringLayer)
            return
        }
        self.layer.addSublayer(self.fillLayer)
        if grade > 0 {
            let gradeColor = self.gradeColor(for: grade)
            let gradeLayer = self.outerLayer
            gradeLayer.fillColor = gradeColor.cgColor
            gradeLayer.strokeColor = gradeColor.cgColor
            self.layer.addSublayer(gradeLayer)
        }
        self.layer.addSublayer(self.ringLayer)
        
        fillLayer.add(animation, forKey: "animateOpacity")
        self.isAnimating = true
    }
    
}
