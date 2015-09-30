//
//  photoViewController.swift
//  testSBR
//
//  Created by Kan Chen on 9/23/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class photoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,CameraOverlayDelegate{
   
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func click(sender: AnyObject) {
        showImagePicker()
    }
    
    func showImagePicker(){
        self.imagePicker = UIImagePickerController()
        guard let imagePicker = self.imagePicker else{
            return
        }
        let sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.sourceType = sourceType
        
        var availableSource = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
        availableSource?.removeLast()
        imagePicker.mediaTypes = availableSource!
        
        imagePicker.delegate = self
        imagePicker.showsCameraControls = false
        
        let xibs = NSBundle.mainBundle().loadNibNamed("CameraOverlay", owner: nil, options: nil)
        let overlayView = xibs.first as? CameraOverlay
        overlayView?.frame = imagePicker.cameraOverlayView!.frame
        imagePicker.cameraOverlayView = overlayView
        overlayView?.delegate = self
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("#####   image")
        print("\(image.imageOrientation.rawValue)")
        
        print("width: \(image.size.width)     height: \(image.size.height)")
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                UIGraphicsBeginImageContext(image.size)
                var context = UIGraphicsGetCurrentContext()
                
                CGContextRotateCTM(context, CGFloat( M_PI_2))
                
                image.drawAtPoint(CGPoint(x: 0, y: 0))
                
                let nnn = UIGraphicsGetImageFromCurrentImageContext()
                self.testimage1.image = image
                
                
                UIGraphicsEndImageContext()
                ////////////
                UIGraphicsBeginImageContext(image.size)
                
                
                context = UIGraphicsGetCurrentContext()
                
                CGContextRotateCTM(context, CGFloat( M_PI))
                
//                image.drawAtPoint(CGPoint(x: 0, y: 0))
//                image.drawInRect(rect: CGRectMake(0, 0, self., <#T##height: CGFloat##CGFloat#>))
                
                let aa = UIGraphicsGetImageFromCurrentImageContext()
                self.testimage2.image = aa
                
                
                let gogogog = Graph().scaleAndRotateImage(image)
                
                
                UIGraphicsEndImageContext()
                
                let pp = UIImage(CGImage: image.CGImage!, scale: 1.0, orientation: UIImageOrientation.Right)
                let imageRef2 = CGImageCreateWithImageInRect(pp.CGImage, CGRectMake(image.size.width * self.picPart!.x, image.size.height * self.picPart!.y, image.size.width * self.picPart!.wp, image.size.height * self.picPart!.hp))
//                self.testimage2.image = UIImage(CGImage: imageRef2!)
                self.testimage2.image = gogogog
                
                let imageRef3 = CGImageCreateWithImageInRect(gogogog.CGImage, CGRectMake(image.size.width * self.picPart!.x, image.size.height * self.picPart!.y, image.size.width * self.picPart!.wp, image.size.height * self.picPart!.hp))
                self.testimage3.image = UIImage(CGImage: imageRef3!)
                let imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(image.size.width * self.picPart!.x, image.size.height * self.picPart!.y, image.size.width * self.picPart!.wp, image.size.height * self.picPart!.hp))
                let newimage = UIImage(CGImage: imageRef!)
                self.imageView.image = newimage
            })
            
            
        }
    }
    
    @IBOutlet var testimage3: UIImageView!
   
    @IBOutlet var testimage2: UIImageView!
    @IBOutlet var testimage1: UIImageView!
    var picRect: CGRect?
    var picPart: RectangleRatio?
    //CameraOverlayDelegate
    func cancelFromImagePicker() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveInImagePicker(ratio:RectangleRatio ) {
        self.imagePicker?.takePicture()
        self.picPart = ratio
    }
    
}
