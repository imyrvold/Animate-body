
//
//  BodyAreaView.swift
//  RegIT
//
//  Created by Ivan C Myrvold on 22.07.2018.
//  Copyright © 2018 Better. All rights reserved.
//

import UIKit

public class BodyAreaView: UIView {
    override public func draw(_ rect: CGRect) {
        let ringPath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 4, dy: 4))
        let con = UIGraphicsGetCurrentContext()!
        con.addPath(ringPath.cgPath)
        con.strokePath()
    }
}
