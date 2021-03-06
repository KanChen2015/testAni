//
//  ViewController.swift
//  testSBR
//
//  Created by Kan Chen on 9/22/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func viewDidAppear(animated: Bool) {
        detect()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func detect(){
        let detector = CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh, CIDetectorMinFeatureSize: 100])
        
        let image = CIImage(image: UIImage(named: "image1")!)!
        var result = image
        var result2 = image
        let opts = [CIDetectorAspectRatio: "1.8"]
        let features = detector.featuresInImage(image, options: opts) as! [CIRectangleFeature]
        for f:CIRectangleFeature in features{
            var overlay = CIImage(color: CIColor(color: UIColor.redColor()))
            overlay = overlay.imageByCroppingToRect(image.extent)
            overlay = overlay.imageByApplyingFilter("CIPerspectiveTransformWithExtent", withInputParameters: ["inputExtent": CIVector(x: 0, y: 0, z: 1, w: 1),
                "inputTopLeft": CIVector(CGPoint: f.topLeft), "inputTopRight": CIVector(CGPoint: f.topRight), "inputBottomLeft": CIVector(CGPoint: f.bottomLeft),"inputBottomRight": CIVector(CGPoint: f.bottomRight)])
            result = overlay.imageByCompositingOverImage(result)
            
        }
        
        var overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.7))
        overlay = overlay.imageByCroppingToRect(features[0].bounds)
        var ciimagewithoverlay = overlay.imageByCompositingOverImage(result2)
        
        imageView.image = UIImage(CIImage: result)
//        imageView.image = UIImage(CIImage:ciimagewithoverlay)
    }

    func detect2(){
        
    }

}

