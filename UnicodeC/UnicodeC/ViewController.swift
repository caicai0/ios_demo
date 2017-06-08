//
//  ViewController.swift
//  UnicodeC
//
//  Created by 李玉峰 on 2017/5/22.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import Cocoa

class ViewController: NSViewController{

    @IBOutlet var textView1: NSTextView!
    @IBOutlet var textView2: NSTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView1.delegate = self
        textView2.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func convertUniCodeString(string:String?) -> String? {
        
        
        return string
    }
    
    func convertStringToUniCode(string:String?) -> String? {
        return string
    }
}

extension ViewController : NSTextViewDelegate{
    func textDidChange(_ notification: Notification) {
        if let textView:NSTextView = notification.object as? NSTextView{
            if textView === textView1 {
                var string = textView1.textStorage?.string
                string = self.convertUniCodeString(string: string)
                textView2.textStorage?.replaceCharacters(in: NSRange(location: 0,length: (textView2.textStorage?.length)!), with: string!)
                
            }else{
                var string = textView2.textStorage?.string
                string = self.convertStringToUniCode(string: string)
                textView1.textStorage?.replaceCharacters(in: NSRange(location: 0,length: (textView1.textStorage?.length)!), with: string!)
            }
        }
    }
}




