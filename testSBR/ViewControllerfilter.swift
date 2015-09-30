//
//  ViewControllerfilter.swift
//  testSBR
//
//  Created by Kan Chen on 9/24/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class ViewControllerfilter: UIViewController {

    @IBOutlet var image2: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var resultImage: UIImageView!
    var image:UIImage?
    override func viewDidAppear(animated: Bool) {
        imageView.image = image
        
        
        detect()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func detect(){
        let detector = CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh, CIDetectorMinFeatureSize: 100])
        
        let image = CIImage(image: self.image!)!
        var result = image
        
        
        let opts = [CIDetectorAspectRatio: "1.8"]
        let features = detector.featuresInImage(image, options: opts) as! [CIRectangleFeature]
        if features.count == 0 {
            return
        }
        
        for f:CIRectangleFeature in features{
            var overlay = CIImage(color: CIColor(color: UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)))
            overlay = overlay.imageByCroppingToRect(image.extent)
            overlay = overlay.imageByApplyingFilter("CIPerspectiveTransformWithExtent", withInputParameters: ["inputExtent": CIVector(x: 0, y: 0, z: 1, w: 1),
                "inputTopLeft": CIVector(CGPoint: f.topLeft), "inputTopRight": CIVector(CGPoint: f.topRight), "inputBottomLeft": CIVector(CGPoint: f.bottomLeft),"inputBottomRight": CIVector(CGPoint: f.bottomRight)])
            result = overlay.imageByCompositingOverImage(result)
            
        }
        let result2 = image
        var overlay = CIImage(color: CIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.7))
        overlay = overlay.imageByCroppingToRect(features[0].bounds)
        
        let ciimagewithoverlay = overlay.imageByCompositingOverImage(result2)
        resultImage.image = UIImage(CIImage:ciimagewithoverlay)

        image2.image = UIImage(CIImage: result)
        }

}
