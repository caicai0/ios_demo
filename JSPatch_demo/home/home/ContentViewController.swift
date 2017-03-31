//
//  ContentViewController.swift
//  home
//
//  Created by liyufeng on 2017/3/14.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var headerHeight : CGFloat = 0  //头的高度
    var offset:CGFloat = 0  //绝对偏移量
    @IBOutlet weak var tableView: UITableView!
    var headerView : headerView?
    
    public var outSideHeaderView : headerView?{
        get{
            return headerView
        }
        set{
            if(headerView != newValue){
                if(headerView != nil){
                    headerView?.removeFromSuperview()
                }
                headerView = newValue
                if((headerView?.superview) != nil){
                    headerView?.removeFromSuperview()
                }
                if self.tableView != nil && headerView != nil{
                    self.updateHeaderHeith(h: (headerView?.bounds.size.height)!)
                    self.tableView.addSubview(headerView!)
                    
                    if self.offset == -((headerView?.bounds.size.height)!-45) {
                        
                    }else{
                        self.tableView.contentOffset = CGPoint(x: 0, y: -self.offset)
                    }
                    
                    updateHeaderView()
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableHeaderView = UIView()
        
        if self.headerView != nil {
            self.tableView.addSubview(headerView!)
            headerView?.snp.makeConstraints({ (make) in
                make.top.equalTo(tableView).offset(0)
                make.left.equalTo(tableView)
            })
            self.updateHeaderHeith(h: (headerView?.bounds.size.height)!)
        }
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateHeaderHeith(h:CGFloat) -> () {
        let view = self.tableView.tableHeaderView
        view?.frame = CGRect(x: 0, y: 0, width: 0, height: h)
        self.tableView.tableHeaderView = view
    }
}

extension ContentViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = NSString(format: "%ld", indexPath.row) as String
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() -> () {
        if headerView != nil {
            var offset:CGFloat = 0
            if tableView.contentOffset.y>((headerView?.bounds.size.height)!-45) {
                offset = tableView.contentOffset.y - ((headerView?.bounds.size.height)! - 45)
            }
            print("相对偏移量\(offset)")
            headerView?.snp.remakeConstraints({ (maker) in
                maker.width.equalTo(tableView)
                maker.top.equalTo(tableView).offset(offset)
                maker.left.equalTo(tableView)
            })
            
            //更新绝对偏移量
            if tableView.contentOffset.y>((headerView?.bounds.size.height)!-45) {
                self.offset = -((headerView?.bounds.size.height)!-45)
            }else if tableView.contentOffset.y>=0 {
                self.offset = -tableView.contentOffset.y
            }
            print("绝对偏移量\(self.offset)")
        }
    }
}
