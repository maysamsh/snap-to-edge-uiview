//
//  UIView+Ext.swift
//  SnapToEdges
//
//  Created by Maysam Shahsavari on 2020-03-13.
//  Copyright © 2020 Maysam Shahsavari. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func createGuidLine(_ position: RulerGuidPosition) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize.zero
        shapeLayer.shadowRadius = 3
        shapeLayer.shadowOpacity = 1
        shapeLayer.strokeColor = UIColor.cyan.cgColor
        shapeLayer.lineWidth = 1
        let linesPath = CGMutablePath()
        
        switch position {
        case .horizontal(let edge):
            let verticalPoints = [CGPoint(x: edge, y: 0),
                           CGPoint(x: edge, y: self.bounds.height)]
            linesPath.addLines(between: verticalPoints)
        case .vertical(let edge):
            let horizontalPoints = [CGPoint(x: 0, y: edge),
                                    CGPoint(x: self.bounds.width, y: edge)]
            linesPath.addLines(between: horizontalPoints)
        }
        
        shapeLayer.path = linesPath
        layer.addSublayer(shapeLayer)
    }
}
