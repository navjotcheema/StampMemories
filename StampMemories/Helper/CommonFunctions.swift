//
//  CommonFunctions.swift
//  Ugurcan
//
//  Created by Arshdeep Kaur on 07/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

// Custom Log
//func printCustom(message: String, function: String = #function) {
//    if enableLogs == 1 {
//        print("\(function): \(message)")
//    }
//}

class CommonFunctions: NSObject {
    // MARK: - Is Valid Email
    
    
    func nullToNil(value : String?) -> String? {
        let empTyValue = ""
        if  value == nil
        {
            return empTyValue
        } else {
            return value
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    //MARK: - Get Optional Decoded String
    func optionalDecodedString(aDecoder: NSCoder, forKey key: String) -> String {
        if let object = aDecoder.decodeObject(forKey: key) as? String {
            return object
        }
        else {
            return ""
        }
    }
    
    //MARK: - Get Optional  String
    func optionalString(dict:NSDictionary, key: String) -> String {
        if let object = dict.value(forKey: key) as? String {
            return object
        }
        else {
            return ""
        }
    }
    
    //MARK: - Get Optional Int
    func optionalInt(dict:NSDictionary, key: String) -> Int {
        if let object = dict.value(forKey: key) as? Int {
            return object
        }
        else {
            return 0
        }
    }
    
   
    func  changeButtonStyle(button :UIButton)
    {
        button.backgroundColor =  UIColor.clear
        button.titleLabel?.textAlignment =  .left
        button.layer.borderColor =  UIColor.black.cgColor
        button.layer.borderColor =  UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.layer.borderWidth = 1.0
        button.contentHorizontalAlignment  = .left
        button.layer.cornerRadius =  5
        button.layer.cornerRadius = 5
        button.titleEdgeInsets.left = 5
    }
    //MARK: -ChangeTextFieldBorderandWidth

    func  changeTextFieldStyle(textField :UITextField)
    {
        textField.layer.borderColor =  UIColor.black.cgColor
        textField.layer.borderColor =  UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.borderWidth = 1.0
        
        textField.layer.cornerRadius =  5
        textField.layer.cornerRadius = 5
    }
    func changeNavBarColor() {
        let barColor = navBarColor
        UINavigationBar.appearance().barTintColor = UIColor(hexString: barColor)
    }
    class func setTextFieldBorder(textfield:UITextField)
    {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - width, width:  textfield.frame.size.width, height: textfield.frame.size.height)
        
        border.borderWidth = width
        textfield.layer.addSublayer(border)
        textfield.layer.masksToBounds = true
        
    }
    class func setUserProfile(user:User) {
        let prefs = UserDefaults.standard
        let encodedObject:NSData = NSKeyedArchiver.archivedData(withRootObject: user) as NSData
        prefs.setValue(encodedObject, forKey: userProfileKey)
        prefs.synchronize()
    }
    
    class func getUserProfile() -> User {
        let prefs = UserDefaults.standard
        
        var user:User = User()
        if let dict = prefs.object(forKey: userProfileKey){
            let encodedObject:NSData = dict as! NSData
            user = NSKeyedUnarchiver.unarchiveObject(with: encodedObject as Data) as! User
        }
        
        return user
    }
  
    
}


