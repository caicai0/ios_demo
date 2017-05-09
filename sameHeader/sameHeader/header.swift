//
//  header.swift
//  sameHeader
//
//  Created by 李玉峰 on 2017/5/3.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import UIKit

class header: UIView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.3)
        headerLabel.text = "   17:28:08.909255 []scrollViewWillBeginDragging:\n17:28:08.909742 [] scrollViewDidScroll:\n        17:28:08.968301 [] scrollViewDidScroll:\n        17:28:08.969321 [] scrollViewWillEndDragging:\n        17:28:08.969484 [] scrollViewDidEndDragging:\n        17:28:08.972121 [] scrollViewWillBeginDecelerating:\n        17:28:08.986924 [] scrollViewDidScroll:\n        17:28:09.003622 [] scrollViewDidScroll:\n        17:28:09.020242 [] scrollViewDidScroll:"
    }
}
