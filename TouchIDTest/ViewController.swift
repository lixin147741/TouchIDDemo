//
//  ViewController.swift
//  TouchIDTest
//
//  Created by 李鑫 on 15/5/3.
//  Copyright (c) 2015年 李鑫. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func touchID() {
        
        var laContext = LAContext()
        
        var authError: NSError?
        
        if laContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &authError) {
            laContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "我要用你的TouchID", reply: { (success, error) -> Void in
                if success {
                    //验证成功
                    
                    let alert = UIAlertController(title: "成功", message: "验证成功", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Cancel, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                } else {
                    //验证失败
                    
                    let alert = UIAlertController(title: "失败", message: "验证失败", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Cancel, handler: nil))
                    
                    switch error!.code {
                    case LAError.UserCancel.rawValue:
                        alert.message = "User Cancelled"
                    case LAError.AuthenticationFailed.rawValue:
                        alert.message = "Authentication Failed"
                    case LAError.PasscodeNotSet.rawValue:
                        alert.message = "Passcode Not Set"
                    case LAError.UserFallback.rawValue:
                        alert.message = "User Chose To Try A PassWord"
                    case LAError.SystemCancel.rawValue:
                        alert.message = "System Cancelled"
                    default:
                        alert.message = "Unable to Authenicate"
                    }
                
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                }
            })
        } else {
            //调用TouchID失败
            
            let alert = UIAlertController(title: "失败", message: "验证失败", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertActionStyle.Cancel, handler: nil))
            
            switch authError!.code {
            case LAError.TouchIDNotAvailable.rawValue:
                alert.message = "TouchID Not Available"
            case LAError.TouchIDNotEnrolled.rawValue:
                alert.message = "TouchID Not Enrolled"
            default:
                alert.message = "Loacl Authenication Not Avaliable"
            }
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

