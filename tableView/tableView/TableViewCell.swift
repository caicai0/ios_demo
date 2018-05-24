//
//  TableViewCell.swift
//  tableView
//
//  Created by cai on 2018/5/23.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private var _model:AnyObject?
    
    public var model:AnyObject? {
        get{
            return _model
        }
        set{
            _model = newValue
            viewHeigth.constant = CGFloat(arc4random()%100)
        }
    }

    @IBOutlet weak var viewHeigth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
