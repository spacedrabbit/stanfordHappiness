//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Louis Tur on 9/10/15.
//  Copyright (c) 2015 Louis Tur. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {

    @IBOutlet weak var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
        }
    }
    
    var happiness: Int = 20 { // 0 = very sad, 100 = ecstatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    private struct Constants{
        static let HappinessGestureScale: CGFloat = 4
    }
    
    func changeHappiness(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    // delegate method for FaceView
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
    
    func updateUI(){
        faceView.setNeedsDisplay()
    }

}
