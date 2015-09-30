//
//  ViewControllerDemo.swift
//  testSBR
//
//  Created by Kan Chen on 9/24/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class ViewControllerDemo: UIViewController, DRCCustomImagePickerControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func click(sender: AnyObject) {
        let customPicker = DRCCustomImagePickerController()
        customPicker.customDelegate = self
        customPicker.showImagePicker(inViewController: self)
    }
    
    func customImagePickerDidFinishPickingImage(rectImage: UIImage) {
        imageView.image = rectImage
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "filter" {
            let dest = segue.destinationViewController as! ViewControllerfilter
            dest.image = imageView.image
        }
    }
    
}
