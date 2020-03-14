//
//  SquareItem.swift
//  SnapToEdges
//
//  Created by Maysam Shahsavari on 2020-03-12.
//  Copyright © 2020 Maysam Shahsavari. All rights reserved.
//

import Foundation
import UIKit

struct SquareItem: Hashable {
    let id: Int
    let center: CGPoint

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
