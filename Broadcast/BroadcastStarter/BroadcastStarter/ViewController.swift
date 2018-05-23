//
//  ViewController.swift
//  BroadcastStarter
//
//  Created by 李玉峰 on 2018/4/24.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController,RPBroadcastActivityViewControllerDelegate {
    
    var broadcastActivityController:RPBroadcastActivityViewController? = nil
    var broadcastController:RPBroadcastController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func start(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            guard (self.broadcastController == nil) else {
                self.broadcastController?.finishBroadcast(handler: { (error) in
                    print(error)
                })
                return
            }
        }else{
            RPBroadcastActivityViewController .load { (activity, error) in
                if error == nil {
                    self.broadcastActivityController = activity
                    activity?.delegate = self as! RPBroadcastActivityViewControllerDelegate
                    self .present(activity!, animated: true, completion: nil)
                }
            }
        }
    }
    
    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController, didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
        broadcastActivityController?.dismiss(animated: true, completion: nil)
        print(broadcastController,error)
        self.broadcastController = broadcastController
        broadcastController?.startBroadcast(handler: { (error) in
            print(error)
        })
    }
}

