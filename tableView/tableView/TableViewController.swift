//
//  TableViewController.swift
//  tableView
//
//  Created by cai on 2018/5/23.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit

@objc class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView .register(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        let header = MJRefreshNormalHeader()
        header
        self.tableView.mj_header = header
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TalbeViewCell", for: indexPath) as! TableViewCell
        cell.model = nil
        return cell
    }

}
