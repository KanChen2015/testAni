//
//  AnimationViewController.swift
//  testSBR
//
//  Created by Kan Chen on 9/30/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    var imageView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let xibs = NSBundle.mainBundle().loadNibNamed("animationView", owner: nil, options: nil)
        let aniView = xibs.first as! animationView
        self.view = aniView
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        let image = UIImage(named: "image1")
        self.imageView = UIImageView(frame: CGRectInset(self.view.frame, 50, 100))
        guard let imageView = self.imageView else{
            return
        }
        imageView.image = image
        self.view.addSubview(imageView)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = imageView.bounds
        let maskPath = CGPathCreateMutable()
        CGPathAddRect(maskPath, nil, maskLayer.bounds)
        CGPathAddEllipseInRect(maskPath, nil, maskLayer.bounds)
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.path = maskPath
        maskLayer.fillColor = UIColor.blackColor().CGColor
        maskLayer.masksToBounds = true
        imageView.layer.mask = maskLayer
//
        print(self.imageView?.layer.mask?.position)
        print(self.imageView?.layer.mask?.bounds)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var w:CGFloat = 0

    @IBAction func click(sender: AnyObject) {
        let durantion:NSTimeInterval  = 2
        CATransaction.begin()
        CATransaction.setValue(durantion, forKey: kCATransactionAnimationDuration)
        var width:CGFloat
        var height:CGFloat
//        if self.w == 200 {
//            width = 250
//            height = 400
//            w = 250
//        }else{
//            width = 200
//            height = 200
//            w = 200
//        }
//        self.imageView?.layer.mask?.frame =         self.imageView?.layer.mask?.position = CGPointMake(0, 0)
        self.imageView?.layer.mask?.bounds = CGRectMake(0, 0, 200, 300)
        CATransaction.commit()
        print(self.imageView?.layer.mask?.position)
        print(self.imageView?.layer.mask?.bounds)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
