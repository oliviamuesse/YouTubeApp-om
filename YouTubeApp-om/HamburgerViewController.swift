//
//  HamburgerViewController.swift
//  YouTubeApp-om
//
//  Created by Olivia Muesse on 10/13/14.
//  Copyright (c) 2014 Olivia Muesse. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var feedContainerView: UIView!
    
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    
    var imageCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        feedViewController = storyboard.instantiateViewControllerWithIdentifier("FeedViewController") as UIViewController
        menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as UIViewController
        menuContainerView.addSubview(menuViewController.view)
        feedContainerView.addSubview(feedViewController.view)
        
        menuContainerView.transform = CGAffineTransformMakeScale(0.9, 0.9)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanRevealMenu(gestureRecognizer: UIPanGestureRecognizer) {
        var translation = gestureRecognizer.translationInView(view)
        var velocity = gestureRecognizer.velocityInView(view)
        var location = gestureRecognizer.locationInView(view)
        
        var scaleIn = convertValue(feedContainerView.frame.origin.x, r1Min: 0.0, r1Max: 280.0, r2Min: 0.9, r2Max: 1.0)
        menuContainerView.transform = CGAffineTransformMakeScale(scaleIn, scaleIn)
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Began")
            imageCenter = feedContainerView.center
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Changed {
            println("Changed")
            feedContainerView.center.x = translation.x + imageCenter.x
            println("\(feedContainerView.center.x)")
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Ended")
            if velocity.x > 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    self.feedContainerView.center.x = 440
                    self.menuContainerView.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: { (finished: Bool) -> Void in
                })
            } else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    self.feedContainerView.center.x = 160
                    self.menuContainerView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    }, completion: nil)
            }
            
        }
        
    }

    func convertValue(value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
