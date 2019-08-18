//
//  FilterViewController.swift
//  SwipeFilteredImages
//
//  Created by G R-Titko on 8/17/19.
//  Copyright © 2019 GRey-T-Programs. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    var pictureFilters = [String]()
    var picureFilterIterator = Int()
    var originalImage = UIImage()
    var currentImage = UIImage()
    var filterImage = UIImage()
    var uiImageViewCurrentImage = UIImageView()
    var uiImageViewNewlyFilteredImage = UIImageView()
    var startLocation = CGPoint()
    var directionAssigned = false
    var reassignIncomingImage = true
    
    enum Direction {
        case LEFT
        case RIGHT
    }
    
    //enum direction _direction
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeFiltering()
    }
    

    func initializeFiltering() {
        pictureFilters = ["CISepiaTone", "CIColorInvert", "CIColorCube", "CIFalseColor", "CIPhotoEffectNoir"]
        picureFilterIterator = 0
        
        originalImage = UIImage(named: "bluemarket copy.jpg")!
        currentImage = UIImage(named: "nssl0091.jpg")!
        uiImageViewCurrentImage = UIImageView(image: currentImage)
        uiImageViewNewlyFilteredImage = UIImageView(frame: CGRect(0,0,view.bounds.size.width, view.bounds.size.height)) 
        let pan = UIPanGestureRecognizer(target: self, action: #selector(swipeRecognized(swipe:)))
        self.view.addGestureRecognizer(pan)
    }

    @objc func swipeRecognized(swipe: UIPanGestureRecognizer) {
        print("Swipe recognized")
        var distance = CGFloat()
        let stopLocation = CGPoint()
        if (swipe.state == UIGestureRecognizer.State.began) {
            directionAssigned = false
            startLocation = swipe.location(in: view)
        } else {
            startLocation = swipe.location(in: view)
            let dx = startLocation.x - startLocation.x
            let dy = stopLocation.y - startLocation.y
            distance = CGFloat(sqrt(dx * dx + dy * dy))
        }
        
        if(swipe.state == UIGestureRecognizer.State.ended) {
            if(((view.bounds.size.width - startLocation.x) + distance) > view.bounds.size.width/2) {
                reassignCurrentImage()
            }
            clearIncomingImage()
            reassignIncomingImage = true
            return
        }
    }
    
    func reassignCurrentImage() {
       uiImageViewCurrentImage.image = filterImage
        view.frame = view.bounds
    }
    
    func applyMask(maskRect: CGRect!){
        let maskLayer: CAShapeLayer = CAShapeLayer()
        let path: CGPath = CGPath(rect: maskRect, transform: nil)
        maskLayer.path = path
        print("Applying mask")
        uiImageViewNewlyFilteredImage.layer.mask = maskLayer
    }
    
    func clearIncomingImage() {
        filterImage = UIImage()
        uiImageViewNewlyFilteredImage.image = UIImage()
        applyMask(maskRect: CGRect(0,0,view.bounds.size.width, view.bounds.size.height))
    }
}
