//
//  main.swift
//  load
//
//  Created by 李玉峰 on 2017/8/8.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import Foundation

request("http://www.baidu.com", method: .get).responseString { (stringResponse) in
    print(stringResponse);
}

print("Hello, World!")

