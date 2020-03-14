
//
//  UIColo+Ext.swift
//  SnapToEdges
//
//  Created by Maysam Shahsavari on 2020-03-11.
//  Copyright © 2020 Maysam Shahsavari. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
