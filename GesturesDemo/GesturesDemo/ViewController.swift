//
//  ViewController.swift
//  GesturesDemo
//
//  Created by Appinventiv on 03/03/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var pinkView: UIView!
    
    var temp: CGFloat = 1.0
  
    var tmpx: CGFloat?
    var tmpy: CGFloat?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.changeScale))
        pinchGesture.delegate = self
        pinkView.addGestureRecognizer(pinchGesture)
        
        
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.selectOnPress))
//        longPressGesture.delegate = self
//        pinkView.addGestureRecognizer(longPressGesture)
//        longPressGesture.minimumPressDuration = 0.3
   
        tmpx = pinkView.center.x
        tmpy = pinkView.center.y

        let penGesture = UIPanGestureRecognizer(target: self, action: #selector(self.detectPan))
        pinkView.addGestureRecognizer(penGesture)
        
    }
    
    
    func changeScale(recognizer: UIPinchGestureRecognizer) {
        
        if recognizer.state == .changed ||  recognizer.state == .began ||  recognizer.state == .ended {
            
            temp *= recognizer.scale
            recognizer.scale = 1.0
            pinkView.transform = CGAffineTransform(scaleX: temp, y: temp)
        }
        print(temp)
    }

   
    func detectPan(recognizer: UIPanGestureRecognizer) {
        
        recognizer.maximumNumberOfTouches = 2
        
        let translation  = recognizer.translation(in: pinkView.superview)
        
        print(recognizer.view?.frame ?? "first scroll")
        var position = recognizer.view?.frame
        
        if ((position?.origin.x)! >= 0 as CGFloat) && ((position?.origin.x)! + (position?.width)!) <= 375 {
            
            if recognizer.state == .changed ||  recognizer.state == .began ||  recognizer.state == .ended {
                
                pinkView.center = CGPoint(x: tmpx! + translation.x, y: tmpy! + translation.y)
                
            }
            
        } else if !((position?.origin.x)! >= 0 as CGFloat) {
        
            if recognizer.state == .changed ||  recognizer.state == .began ||  recognizer.state == .ended {
            
                pinkView.center = CGPoint(x: (recognizer.view?.frame.width)! / 2.0, y: tmpy! + translation.y)
                
            }
        
        } else if !(((position?.origin.x)! + (position?.width)!) <= 375) {
            
            if recognizer.state == .changed ||  recognizer.state == .began ||  recognizer.state == .ended {
                
                pinkView.center = CGPoint(x: 375 - (recognizer.view?.frame.width)! / 2.0, y: tmpy! + translation.y)
                
            }
        }
        
        
        if recognizer.state == .ended {
            
            tmpx = pinkView.center.x
            tmpy = pinkView.center.y
            
        }
        
    }
    
}






//    func selectOnPress(gesture : UILongPressGestureRecognizer){
//
//         if gesture.state == .ended {
//            return
//        }
//        let pressPoint = gesture.location(in: self.pinkView)
//        print(pressPoint)
//    }
