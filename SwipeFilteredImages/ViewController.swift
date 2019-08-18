//
//  ViewController.swift
//  SwipeFilteredImages
//
//  Created by G R-Titko on 8/16/19.
//  Copyright © 2019 GRey-T-Programs. All rights reserved.
//
//Inspiration: https://stackoverflow.com/questions/23319497/swipe-between-filtered-images
//https://github.com/pauljeannot/SnapSliderFilters/blob/master/SnapSliderFilters/Classes/SNSlider.swift
import UIKit
import CoreGraphics

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var topImage: UIImageView!
    @IBOutlet var bottomImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 2*self.view.bounds.width, height: self.view.bounds.height)
        
        applyMask(maskRect: CGRect(self.view.bounds.width-scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.contentSize.width, scrollView.contentSize.height))
    }
    
    func applyMask(maskRect: CGRect!){
        let maskLayer: CAShapeLayer = CAShapeLayer()
        let path: CGPath = CGPath(rect: maskRect, transform: nil)
        maskLayer.path=path
        print("Applying mask")
        topImage.layer.mask = maskLayer
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        applyMask(maskRect: CGRect(self.view.bounds.width-scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.contentSize.width, scrollView.contentSize.height))
    }


}

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
