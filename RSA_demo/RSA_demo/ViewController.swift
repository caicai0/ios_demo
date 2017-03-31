//
//  ViewController.swift
//  RSA_demo
//
//  Created by liyufeng on 2017/3/31.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

//生成公钥私钥的命令  ssh-keygen -t rsa -b 4096 -C "email@example.com"

/*
 $ ssh-keygen -t rsa -f ./mykey -N ''
 $ cat ~/mykey > ./private.pem
 $ ssh-keygen -f ./mykey.pub -e -m pem > ./public.pem
 */

import UIKit
import SwiftyRSA
import SwiftyRSA.NSData_SHA

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        use1()
        
//        use2()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func use1(){//加密解密
        let content = "Clear TextClear TextClear TextClear TextClear TextClear TextClear TextClear TextClear TextClear Text"
        let data : NSData? = content.data(using: .utf8) as NSData?
        let sha512 = data?.swiftyRSASHA512()
        let shaString = sha512?.base64EncodedString()
        print(shaString!)
        
        let publicKey = try! PublicKey(pemNamed: "public")
        let clear = try! ClearMessage(string: shaString!, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        let base64String = encrypted.base64String
        print(base64String)
        
        let privateKey = try! PrivateKey(pemNamed: "private")
        let encrypted2 = try! EncryptedMessage(base64Encoded: base64String)
        let clear2 = try! encrypted2.decrypted(with: privateKey, padding: .PKCS1)
        
        let string = try! clear2.string(encoding: .utf8)
        print(string)
    }

    func use2(){//签名  验证签名
        let privateKey = try! PrivateKey(pemNamed: "private")
        let clear = try! ClearMessage(string: "Clear Text", using: .utf8)
        let signature = try! clear.signed(with: privateKey, digestType: .sha512)
        
        let base64String = signature.base64String
        print(base64String)
        
        let publicKey = try! PublicKey(pemNamed: "public")
        let signature2 = try! Signature(base64Encoded: base64String)
        let isSuccessful = try! clear.verify(with: publicKey, signature: signature2, digestType: .sha512)
        print(isSuccessful.isSuccessful)
    }

}

