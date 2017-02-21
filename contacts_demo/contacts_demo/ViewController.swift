//
//  ViewController.swift
//  contacts_demo
//
//  Created by liyufeng on 2017/2/21.
//  Copyright © 2017年 liyufeng. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        func2()
        func3()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func func2() -> () {
        let contact = CNMutableContact()
        contact.givenName = "abc"
        contact.familyName = "test"
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: "123@bac.com" as NSString)
        let workEmail = CNLabeledValue(label: CNLabelWork, value: "345@abc.com" as NSString)
        contact.emailAddresses = [homeEmail,workEmail]
        
        let phonenumber = CNLabeledValue(label: CNLabelPhoneNumberiPhone, value: CNPhoneNumber(stringValue: "1231312312123123"))
        contact.phoneNumbers = [phonenumber]
        
        let homeAdress = CNMutablePostalAddress()
        homeAdress.street = "beijing"
        homeAdress.city = "beijing"
        homeAdress.postalCode = "123123"
        contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAdress)]
        
        var birethday = DateComponents()
        birethday.day = 12
        birethday.month = 5
        birethday.year = 197
        contact.birthday = birethday
        
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: nil)
        
        let store = CNContactStore()
        
        do {
            try store.execute(request)
        } catch let e {
            print(e)
        }
    }
    
    func func3() -> () {
        let path = Bundle.main.path(forResource: "txl", ofType: "csv")
        do {
            let string = try String(contentsOfFile: path!)
            let lines = string.components(separatedBy: "\n")
            let request = CNSaveRequest()
            var lastDepartment = "";
            for line in lines {
                var labels = line.components(separatedBy: ",");
                let name = labels[0]
                let phone = labels[1]
                let email = labels[2]
                let department : String = labels[3]
                let title = labels[4]
                
                let lastName = name.substring(to: name.index(name.startIndex, offsetBy: 1))
                let givenName = name.substring(from: name.index(name.startIndex, offsetBy:1))
                
                let contact = CNMutableContact()
                contact.givenName = givenName
                contact.familyName = lastName
                
                let phonenumber = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: phone))
                contact.phoneNumbers = [phonenumber]
                
                let workEmail = CNLabeledValue(label: CNLabelWork, value: email as NSString)
                contact.emailAddresses = [workEmail]
                
                contact.organizationName = "北京华媒康讯信息技术有限公司"
                if department != "" {
                    contact.departmentName = department;
                    lastDepartment = department;
                }else{
                    contact.departmentName = lastDepartment;
                }
                
                contact.jobTitle = title;
                
                request.add(contact, toContainerWithIdentifier: nil)
            }
            
            let store = CNContactStore()
            
            do {
                try store.execute(request)
            } catch let e {
                print(e)
            }
            
        } catch let e {
            print(e)
        }
    }


}

