//
//  ViewController.swift
//  SimpleFlash
//
//  Created by MacBookPro on 2016. 12. 22..
//  Copyright © 2016년 EDCAN. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet private var torchSwitch : UISwitch!
    @IBOutlet private var torchInfo : UITextField!
    private let avCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType : AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        torchSwitch.setOn(false, animated: false)
    }
    
    func ledStateChange(state : Bool){
        if let avCaptureDevice = avCaptureDevice{
            if avCaptureDevice.hasTorch{
                do{
                    try avCaptureDevice.lockForConfiguration()
                    
                    print(state)
                    if state{
                        avCaptureDevice.torchMode = .on
                    }else{
                        avCaptureDevice.torchMode = .off
                    }
                    
                    avCaptureDevice.unlockForConfiguration()
                }catch{
                    torchInfo.text = "Un Error occured"
                    return
                }
            }else{
                torchInfo.text = "Current device doesn't have a LED Flash"
                return
            }
        }
    }
    
    @IBAction func switchDidEvent(sender : UISwitch){
        ledStateChange(state: sender.isOn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

