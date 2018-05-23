//
//  BroadcastSetupViewController.swift
//  UploadSetupUI
//
//  Created by 李玉峰 on 2018/4/25.
//  Copyright © 2018年 cai. All rights reserved.
//

import ReplayKit

class BroadcastSetupViewController: UIViewController {

    
    @IBOutlet weak var texturl: UITextField!
    
    
    @IBAction func OK(_ sender: UIButton) {
        userDidFinishSetup()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        userDidCancelSetup()
    }
    
    func userDidFinishSetup() {
        // URL of the resource where broadcast can be viewed that will be returned to the application
        let broadcastURL = URL(string:"http://apple.com/broadcast/streamID")
        
        // Dictionary with setup information that will be provided to broadcast extension when broadcast is started
        let setupInfo: [String : NSCoding & NSObjectProtocol] = ["broadcastName": "example" as NSCoding & NSObjectProtocol]
        
        // Tell ReplayKit that the extension is finished setting up and can begin broadcasting
        self.extensionContext?.completeRequest(withBroadcast: broadcastURL!, setupInfo: setupInfo)
    }
    
    func userDidCancelSetup() {
        let error = NSError(domain: "YouAppDomain", code: -1, userInfo: nil)
        // Tell ReplayKit that the extension was cancelled by the user
        self.extensionContext?.cancelRequest(withError: error)
    }
}
