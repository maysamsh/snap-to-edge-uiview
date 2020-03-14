//
//  CGPoint+Ext.swift
//  SnapToEdges
//
//  Created by Maysam Shahsavari on 2020-03-12.
//  Copyright © 2020 Maysam Shahsavari. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    static func random(in rect: CGRect) -> CGPoint {
        let width = rect.width * 0.7
        let height = rect.height * 0.7
        let x = CGFloat.random(in: (rect.width * 0.15)...width)
        let y = CGFloat.random(in: (rect.height * 0.15)...height)
        return CGPoint(x: x, y: y)
    }
}
