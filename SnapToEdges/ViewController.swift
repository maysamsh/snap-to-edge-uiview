//
//  ViewController.swift
//  SnapToEdges
//
//  Created by Maysam Shahsavari on 2020-03-11.
//  Copyright © 2020 Maysam Shahsavari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var squareItems = [Int: CGPoint]()
    var snapIsEnabled = true
    var rulerGuidesView: UIView?
    var feedbackIsAllowed: Bool = true
    
    @IBOutlet weak var toggleSnap: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configreUI()
    }
    
    func configreUI(){
        toggleSnap.title = "Turn Off Snap"
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        guard let senderView = recognizer.view as? MovableSquare else {
            return
        }
        
        let translation = recognizer.translation(in: self.view)
        
        var shouldSnap = false
        var snapOnLeftEdge = false
        var snapOnTopEdge = false
        var horizontalDifference: CGFloat = 0.0
        var verticalDiffecence: CGFloat = 0.0
        let newPoint = CGPoint(x: senderView.center.x + translation.x, y: senderView.center.y + translation.y)
        
        if recognizer.state != .cancelled {
            
            func applyNormalPan(){
                senderView.center = newPoint
            }
            
            // Don't bother to calculate if the snap is disabled
            if snapIsEnabled {
                for item in squareItems {
                    if item.key != senderView.hash {
                        let leftDistance = abs(senderView.frame.origin.x + translation.x - item.value.x)
                        if leftDistance < 5 {
                            snapOnLeftEdge = true
                            shouldSnap = true
                            horizontalDifference = senderView.frame.origin.x + translation.x - item.value.x
                        }
                        
                        let topDistance = abs(senderView.frame.origin.y + translation.y - item.value.y)
                        if topDistance < 5 {
                            snapOnTopEdge = true
                            shouldSnap = true
                            verticalDiffecence = senderView.frame.origin.y + translation.y - item.value.y
                        }
                    }
                }
            }
            
            if shouldSnap {
                if snapOnLeftEdge {
                    var _frame = senderView.frame
                    _frame.origin.x = _frame.origin.x + translation.x - horizontalDifference
                    _frame.origin.y = _frame.origin.y + translation.y
                    senderView.frame = _frame
                    
                    if feedbackIsAllowed {
                        feedbackIsAllowed = false
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        if let _rulersGuid = setupRulerGuidesView(.horizontal(_frame.origin.x)) {
                            self.view.addSubview(_rulersGuid)
                            _rulersGuid.layer.zPosition = 2
                        }
                    }
                    
                } else if snapOnTopEdge {
                    var _frame = senderView.frame
                    _frame.origin.x = _frame.origin.x + translation.x
                    _frame.origin.y = _frame.origin.y + translation.y - verticalDiffecence
                    senderView.frame = _frame
                    
                    if feedbackIsAllowed {
                        feedbackIsAllowed = false
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        if let _rulersGuid = setupRulerGuidesView(.vertical(_frame.origin.y)) {
                            self.view.addSubview(_rulersGuid)
                            _rulersGuid.layer.zPosition = 2
                        }
                    }
                } else {
                    // If !snapOnTopEdge
                    applyNormalPan()
                    feedbackIsAllowed = true
                    removeRulreGuides()
                }
            } else {
                // If !shouldSnap
                applyNormalPan()
                feedbackIsAllowed = true
                removeRulreGuides()
            }
            
            // Reste the velocity of the pan
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            // Update the items array
            squareItems[senderView.hash] = CGPoint(x: senderView.frame.origin.x, y: senderView.frame.origin.y)
            removeRulreGuides()
        }
    }
    
    func setupRulerGuidesView(_ position: RulerGuidPosition) -> UIView? {
        rulerGuidesView = UIView(frame: self.view.bounds)
        rulerGuidesView?.backgroundColor = UIColor.clear
        rulerGuidesView?.createGuidLine(position)
        
        return rulerGuidesView
    }
    
    func removeRulreGuides(){
        rulerGuidesView?.removeFromSuperview()
        rulerGuidesView = nil
    }
    
    @IBAction func addNewSquare(_ sender: UIBarButtonItem) {
        let view = MovableSquare(viewController: self, panHandler: #selector(panGesture(recognizer:)))
        view.center = CGPoint.random(in: self.view.bounds)
        
        self.view.addSubview(view)
        squareItems[view.hash] = CGPoint(x: view.frame.origin.x, y: view.frame.origin.y)
    }
    
    @IBAction func toggleSnap(_ sender: UIBarButtonItem) {
        toggleSnap.title = snapIsEnabled == true ? "Turn On Snap" : "Turn Off Snap"
        snapIsEnabled = !snapIsEnabled
    }
}

