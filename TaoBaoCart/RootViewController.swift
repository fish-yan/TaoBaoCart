//
//  RootViewController.swift
//  TaoBaoCart
//
//  Created by 薛焱 on 16/4/20.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    var cartView: UIView!
    var maskView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height/2))
        cartView.backgroundColor = UIColor.cyanColor()
        // Do any additional setup after loading the view.
    }

    @IBAction func present(sender: UIButton) {
        var rect = self.cartView.frame
        rect.origin.y = UIScreen.mainScreen().bounds.size.height / 2
        maskView = UIView(frame: view.bounds)
        maskView.backgroundColor = UIColor.blackColor()
        maskView.alpha = 0.0
        view.addSubview(maskView)
        UIView.animateWithDuration(0.3, animations: {
            self.maskView.alpha = 0.5
            self.view.layer.transform = self.firstTran()
        }) { (finish: Bool) in
            
            UIView.animateWithDuration(0.3, animations: {
                self.view.layer.transform = self.secondTran()
                
                self.cartView.frame = rect
                UIApplication.sharedApplication().windows[0].addSubview(self.cartView)
                }, completion:nil)
        }
    }
    
    func firstTran() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform.m24 = -1/2000
        transform = CATransform3DScale(transform, 0.9, 0.9, 1)
        return transform
    }
    
    func secondTran() -> CATransform3D {
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, self.view.frame.size.height * (-0.08), 0)
        transform = CATransform3DScale(transform, 0.8, 0.8, 1)
        return transform
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var rect = self.cartView.frame
        rect.origin.y = UIScreen.mainScreen().bounds.size.height
        UIView.animateWithDuration(0.3, animations: {
            self.view.layer.transform = self.firstTran()
            self.cartView.frame = rect
            self.maskView.alpha = 0.0
        }) { (finish: Bool) in
            self.cartView.removeFromSuperview()
            UIView.animateWithDuration(0.3, animations: {
                self.view.layer.transform = CATransform3DIdentity
                }, completion: nil)
            
        }
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
