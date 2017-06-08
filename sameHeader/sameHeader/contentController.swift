//
//  contentController.swift
//  sameHeader
//
//  Created by 李玉峰 on 2017/5/3.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import UIKit

class contentController: UIViewController {
    @IBOutlet open weak var tableView: UITableView!
    var localSize:CGSize = CGSize.zero
    weak var localHeader:UIView? = nil
    
    open var header:UIView?{
        set{
            localHeader = header
            //初始化操作
        }
        get{
            return localHeader
        }
    }
    
    open var headerSize:CGSize {
        set{
            localSize = newValue
            tableView.contentInset = UIEdgeInsetsMake(localSize.height+64, 0, 0, 0)
        }
        get{
            return localSize
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension contentController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "slldk\(indexPath.row)";
        return cell
    }
    
    //UIScrollViewDelegate
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
