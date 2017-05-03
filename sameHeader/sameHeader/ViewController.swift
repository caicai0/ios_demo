//
//  ViewController.swift
//  sameHeader
//
//  Created by 李玉峰 on 2017/5/3.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        let controller1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contentController")
        let controller2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contentController")
        self.addChildViewController(controller1)
        self.addChildViewController(controller2)
        scrollView.addSubview(controller1.view)
        scrollView.addSubview(controller2.view)
        controller1.view.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        controller2.view.snp.makeConstraints { (maker) in
            maker.left.equalTo(controller1.view.snp.right)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.right.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

