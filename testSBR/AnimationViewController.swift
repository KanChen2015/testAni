//
//  AnimationViewController.swift
//  testSBR
//
//  Created by Kan Chen on 9/30/15.
//  Copyright © 2015 Kan Chen. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        let xibs = NSBundle.mainBundle().loadNibNamed("animationView", owner: nil, options: nil)
        let aniView = xibs.first as! animationView
        self.view = aniView
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

}
