//
//  SliderWidget.swift
//  SliderWidget
//
//  Created by Annemarie Ketola on 3/23/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

import UIKit

class SliderWidget: UIView {

    // TODO: Add inspectable elements to control UI
    @IBInspectable var minValue: CGFloat = 0
    @IBInspectable var maxValue: CGFloat = 100
    
    @IBOutlet weak var foregroundTickerImageView: UIImageView!
    @IBOutlet weak var sliderMarksImageView: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var view: UIView!
    var nibName = "SliderWidget"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        
        view.frame = bounds
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        addSubview(view)
        
        // add gesture
        
        var panGesture = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        addGestureRecognizer(panGesture)
        
        userInteractionEnabled = true
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state == UIGestureRecognizerState.Changed {
            
            // Move the slider left or right each time the view is panned
            var dt = panGesture.translationInView(self)
            panGesture.setTranslation(CGPointZero, inView: self)
            
            
            sliderMarksImageView.center.x += dt.x
            
        } else if panGesture.state == UIGestureRecognizerState.Cancelled ||
            panGesture.state == UIGestureRecognizerState.Ended
            || panGesture.state == UIGestureRecognizerState.Failed {
                
                // animate the slider if it goes outside the bounds
                
                // Use a springy animation here
                
                var boundsLeft: CGFloat = 0
                var boundsRight: CGFloat = sliderMarksImageView.bounds.size.width
                
                println("bounds: \(boundsLeft):\(boundsRight)")
                println(sliderMarksImageView.center.x)
                
                if sliderMarksImageView.center.x < boundsLeft {
                    
                    println("left snap")
                    
                    UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.AllowUserInteraction, animations: {
                        
                        self.sliderMarksImageView.center.x = boundsLeft
                        
                        
                        }, completion: nil)
                    
                } else if sliderMarksImageView.center.x > boundsRight {
                    println("right snap")
                    UIView.animateWithDuration(0.75, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.AllowUserInteraction, animations: {
                        self.sliderMarksImageView.center.x = boundsRight
                        
                        }, completion: nil)
                }
        }
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        
        return view
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 600, height: 80)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
