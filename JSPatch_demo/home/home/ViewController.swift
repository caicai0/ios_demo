//
//  ViewController.swift
//  home
//
//  Created by liyufeng on 2017/3/13.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController,TYPagerControllerDataSource,TYPagerControllerDelegate {

    var offset : CGFloat = 0
    var headview : headerView?
    var pagerController : TYPagerController?
    var headSize : CGSize? = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headview = UINib(nibName: "headerView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! headerView?
        headview?.snp.makeConstraints({ (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
        })
        headview?.headLbl.text = "但如果需要兼容iOS 8之前版本的话，就要回到老路子上了，主要是用systemLayoutSizeFittingSize来取高。步骤是先在数据model中添加一个height的属性用来缓存高，然后在table view的heightForRowAtIndexPath代理里static一个只初始化一次的Cell实例，然后根据model内容填充数据，最后根据cell的contentView的systemLayoutSizeFittingSize的方法获取到cell的高。具体代码如下"
        headSize = headview?.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        print("\(headSize)")
        print("\(UIScreen.main.bounds.size.width)")
        
        pagerController = TYPagerController()
        pagerController?.delegate = self
        pagerController?.dataSource = self
        
        self.view.addSubview((pagerController?.view)!)
        pagerController?.view.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        self.view.addSubview(headview!)
        headview?.snp.makeConstraints({ (maker) in
            maker.top.equalTo(self.view)
            maker.left.equalTo(self.view)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    func numberOfControllersInPagerController() -> Int {
        return 3
    }
    
    func pagerController(_ pagerController: TYPagerController!, controllerFor index: Int) -> UIViewController! {
        let contentController : ContentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController;
        if index == 0 {
            contentController.outSideHeaderView = self.headview;
        }
        return contentController;
    }
    
    func pagerControllerStartMove(_ pagerController: TYPagerController!) {
        if self.headview?.superview != self.view {
            
            let contentController : ContentViewController = pagerController.visibleControllers[NSNumber(integerLiteral: pagerController.curIndex)] as! ContentViewController
            self.offset = contentController.offset
            contentController.outSideHeaderView = nil
            
            self.headview?.removeFromSuperview()
            self.view.addSubview(self.headview!)
            self.headview?.snp.remakeConstraints({ (maker) in
                maker.width.equalTo(UIScreen.main.bounds.size.width)
                maker.top.equalTo(self.view).offset(self.offset)
                maker.left.equalTo(self.view)
            })
        }
    }
    
    func pagerControllerinMove(_ pagerController: TYPagerController!) {
        
        if self.headview?.superview != self.view {
            
            let contentController : ContentViewController = pagerController.visibleControllers[NSNumber(integerLiteral: pagerController.curIndex)] as! ContentViewController
            self.offset = contentController.offset
            contentController.outSideHeaderView = nil
            
            self.headview?.removeFromSuperview()
            self.view.addSubview(self.headview!)
            self.headview?.snp.remakeConstraints({ (maker) in
                maker.width.equalTo(UIScreen.main.bounds.size.width)
                maker.top.equalTo(self.view).offset(self.offset)
                maker.left.equalTo(self.view)
            })
        }
    }
    
    func pagerControllerStopMove(_ pagerController: TYPagerController!) {
    
        let contentController : ContentViewController = pagerController.visibleControllers[NSNumber(integerLiteral: pagerController.curIndex)] as! ContentViewController
        contentController.offset = self.offset
        contentController.outSideHeaderView = self.headview
    }
    
}

