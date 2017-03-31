//
//  headerView.swift
//  home
//
//  Created by liyufeng on 2017/3/14.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

import UIKit

class headerView: UIView {
    
    public var headString : String? {
        set{
            headLbl.text = headString
        }
        get{
            return headLbl.text
        }
    }
    
    @IBOutlet weak var headLbl: UILabel!
}
