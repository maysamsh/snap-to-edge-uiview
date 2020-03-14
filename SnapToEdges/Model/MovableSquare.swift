//
//  MovableSquare.swift
//  SnapToEdges
//
//  Created by Maysam Shahsavari on 2020-03-11.
//  Copyright © 2020 Maysam Shahsavari. All rights reserved.
//

import UIKit

class MovableSquare: UIView {
    private var _panHandler: Selector?
    private var _viewController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    convenience init(viewController: UIViewController, panHandler: Selector) {
        self.init(frame: CGRect.zero)
        _panHandler = panHandler
        _viewController = viewController
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configure() {
        self.backgroundColor = UIColor.random
        self.frame.size = CGSize(width: 50, height: 50)
        if let viewController = _viewController, let pandHandler = _panHandler {
            self.addGestureRecognizer(UIPanGestureRecognizer(target: viewController, action: pandHandler))
        } 
    }
}
