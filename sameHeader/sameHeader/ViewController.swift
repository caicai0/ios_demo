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
    var headerSize:CGSize = CGSize(width: 0, height: 0)
    var controllers:[UIViewController] = []
    var headerView:header? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self;
        addViews()
        addheaderView()
    }
    
    func addViews() -> () {
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
        controllers.append(controller1)
        controllers.append(controller2)
    }
    
    func addheaderView() -> () {
        self.headerView = UINib(nibName: "header", bundle: nil).instantiate(withOwner: nil, options: nil).first as? header
        self.view.addSubview(headerView!)
        headerView?.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
        }
        updateHeaderSize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateHeaderSize() -> () {
        headerSize = (headerView?.systemLayoutSizeFitting(UILayoutFittingCompressedSize))!
        for controller in controllers {
            if controller.isKind(of: contentController.self) {
                let content:contentController = controller as! contentController
                content.headerSize = self.headerSize;
            }
        }
    }
    
    //添加header到controller
    func moveHeaderIn() -> () {
        
    }
    
    //移动header到contentcontroller
    func modeHeaderOut() -> () {
        
    }
    //当滑动到一半的时候需要调整内容页面的偏移量 和 header的位置相匹配
    func prepareOffsetForHeader(from:contentController ,to:contentController) -> () {
        if from.tableView.contentOffset.y <= (self.headerView?.bounds.size.height)! {
            
        }
    }
    
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("\(#function) in \(#file)\n")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("\(#function) in \(#file)\n")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(#function) in \(#file)\n")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("\(#function) in \(#file)\n")
    }
}

