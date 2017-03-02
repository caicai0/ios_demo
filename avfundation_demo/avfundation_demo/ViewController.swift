//
//  ViewController.swift
//  avfundation_demo
//
//  Created by liyufeng on 2017/2/27.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func func1() -> () {
        //创建一个资源
        let url = Bundle.main.url(forResource: "", withExtension: "")
        let options = [AVURLAssetReferenceRestrictionsKey:true] //可选参数 消耗资源
        let anAsset = AVURLAsset(url: url!, options: options)
    }
    
    

}

