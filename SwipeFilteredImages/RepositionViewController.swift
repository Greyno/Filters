//
//  RepositionViewController.swift
//  SwipeFilteredImages
//
//  Created by Gillian Reynolds-Titko on 8/17/19.
//  Copyright © 2019 GRey-T-Programs. All rights reserved.
//
//Source code: https://stackoverflow.com/questions/37286952/move-uiimageview-independently-from-its-mask-in-swift
import UIKit

class RepositionViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var dragDelta = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attachMask()
        // listen for pan/drag events //
        let pan = UIPanGestureRecognizer(target:self, action:#selector(onPanGesture))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    @objc func onPanGesture(gesture:UIPanGestureRecognizer)
    {
        let point:CGPoint = gesture.location(in: self.view)
        if (gesture.state == .began){
            print("begin", point)
            // capture our drag start position
            dragDelta = CGPoint(x:point.x-imageView.frame.origin.x, y:point.y-imageView.frame.origin.y)
        }   else if (gesture.state == .changed){
            // update image position based on how far we've dragged from drag start
            imageView.frame.origin.y = point.y - dragDelta.y
        }   else if (gesture.state == .ended){
            print("ended", point)
        }
    }
    
    func attachMask()
    {
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 100, width: imageView.frame.size.width, height: 400), cornerRadius: 5).cgPath
        mask.anchorPoint = CGPoint(x: 0, y: 0)
        mask.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(mask)
        imageView.layer.mask = mask; // w/o this, the image isn't masked to the small rect area
    }

}
