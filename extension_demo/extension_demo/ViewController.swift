//
//  ViewController.swift
//  extension_demo
//
//  Created by 李玉峰 on 2018/4/23.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func activityS(_ sender: Any) {
        activity()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func activity() {
        let shareText = "分享标题"
        let shareImage = UIImage()
        let shareUrl = URL(string: "http://www.baidu.com")
        let activityController = UIActivityViewController(activityItems: [shareText,shareImage,shareUrl], applicationActivities: nil)
        activityController.excludedActivityTypes = [UIActivityType.postToFacebook,UIActivityType.postToTwitter,UIActivityType.postToWeibo,UIActivityType.mail,UIActivityType.print,UIActivityType.copyToPasteboard,UIActivityType.assignToContact,UIActivityType.saveToCameraRoll,UIActivityType.addToReadingList,UIActivityType.postToFlickr,UIActivityType.postToVimeo,UIActivityType.postToTencentWeibo,UIActivityType.airDrop,UIActivityType.openInIBooks,UIActivityType.markupAsPDF]
        self.present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = {(type: UIActivityType?,completed: Bool,items: [Any]?,error: Error?) -> Swift.Void in
            print(type,completed,items,error)
            activityController.dismiss(animated: true, completion: nil)
        }
    }

}

