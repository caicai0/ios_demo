//
//  TableViewController.swift
//  tableView
//
//  Created by cai on 2018/5/23.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit

@objc class TableViewController: UITableViewController {

    var number : Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        let header = MJRefreshNormalHeader()
        header.refreshingBlock = {
            self.number = 20;
            self.tableView .reloadData();
            header.endRefreshing()
        }
        self.tableView.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter();
        footer.refreshingBlock = {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2), execute: {
                self.number = self.number+20;
                self.tableView.reloadData()
                if self.number > 40 {
                    footer.endRefreshingWithNoMoreData()
                }else{
                    footer.endRefreshing()
                }
            })
        }
        self.tableView.mj_footer = footer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Int(self.number);
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.model = nil
        return cell
    }

}
