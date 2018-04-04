//
//  BusinessLayer.swift
//  NODAT
//
//  Created by NavdeepSingh on 28/02/17.
//  Copyright © 2017 Trantor Inc. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
@objc protocol BusinessLayerDelegate {
    @objc optional func didFinishedWithError(_ errorMessage:String)
    @objc optional func didFinishedWithData(_ responseMessage:NSMutableDictionary)
    @objc optional func didFinishedSignupWithData(_ responseMessage:NSString)
    @objc optional func didfinishDatawithArray(_ responseArray:NSMutableArray)
    
}
enum enRequestType:Int {
    case enApiLogin
    case enApiRegister
    case enApiGetCustomer
    case enApiGetProvider

}
class BusinessLayer: NSObject,commManagerDelegate
{
    func communicationManagerDidFinishGet(_ response: NSMutableDictionary) {
        
    }
    
    var delegate:BusinessLayerDelegate?
    var commMgr:CommManager
    var currentRequest:enRequestType?
    
    override init()
    {
        commMgr = CommManager()
    }
    

    func register(firstname:String,lastname:String,business_name:String,representative_first_name:String,representative_last_name:String,role_id:String,country_code:String,phone:String,email:String,password:String,devicetype:String,user_service_type:String,devicetoken:String,latitude:String,longitude:String,location:String,user_type:String,register_type:String,social_id:String,social_type:String)
    {
        currentRequest = enRequestType.enApiRegister
        commMgr.delegate = self;
        
        let UrlString = base_URL + registerUrl
        let floatLatitude :Float =  Float(latitude)!
        let floatLong :Float =  Float(longitude)!
        
        
        print(floatLatitude)
        let postParams = ["firstname":firstname,"lastname":lastname,"business_name":business_name,"representative_first_name":representative_first_name,"representative_last_name":representative_last_name,"role_id":role_id,"country_code":country_code,"phone":phone,"email":email,"password":password,"devicetype":devicetype,"user_service_type":user_service_type,"devicetoken":devicetoken,"latitude":floatLatitude,"longitude":floatLong,"location":location,"user_type":user_type,"register_type":register_type,"social_id":social_id,"social_type":social_type] as? [String : Any]
        commMgr.receiveParams(postParams! , urlStr:UrlString)
        
        
    }
   
    func getCustomer()
    {
        currentRequest = enRequestType.enApiGetCustomer
        commMgr.delegate = self;
        
        let UrlString = base_URL + getCustomerRolesURL
        
        let postParams = ["":""]
        print(postParams)
        commMgr.receiveParams(postParams, urlStr:UrlString)
        
    }
    func getProvider()
    {
        currentRequest = enRequestType.enApiGetCustomer
        commMgr.delegate = self;
        
        let UrlString = base_URL + getProviderRolesURL
        
        let postParams = ["":""]
        print(postParams)
        commMgr.receiveParams(postParams, urlStr:UrlString)
        
    }

    func Login(email:String,password:String,devicetype:String,login_type:String,devicetoken:String,social_id:String)
    {
        currentRequest = enRequestType.enApiLogin
        commMgr.delegate = self;
        
        let UrlString = base_URL + login_URL
        
        let postParams = ["email":email,"password":password,"devicetype":devicetype,"login_type":login_type,"devicetoken":devicetoken,"social_id":social_id]
        print(postParams)
        commMgr.receiveParams(postParams, urlStr:UrlString)
        
    }
    
    
    func communicationManagerDidFinish(_ response: String) {
        
        switch(currentRequest!)
        
        
        {
        case .enApiLogin:
            if let data = response.data(using: String.Encoding.utf8) {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data,
                                                                options: .mutableContainers) as? NSMutableDictionary
                    print(json!.value(forKey: "message") as! String)
                    if let JsonResult = json!.value(forKey: "status") as? Int
                    {
                        if JsonResult == 200
                        {
                            
                            delegate?.didFinishedWithData!(json!)
                            
                        }
                        else
                        {
                            let JsonResultMessage = json!.value(forKey: "message") as! String
                            
                            delegate?.didFinishedWithError!(JsonResultMessage)
                        }
                        
                    }
                    else
                    {
                        delegate?.didFinishedWithError!("Server Error")
                    }
                }
                catch
                    
                {
                    delegate?.didFinishedWithError!("Api Error")
                    print("Something went wrong")
                    
                }
            }
            break
        case .enApiRegister:
            if let data = response.data(using: String.Encoding.utf8) {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data,
                                                                options: .mutableContainers) as? NSMutableDictionary
                    print(json!.value(forKey: "message") as! String)
                    if let JsonResult = json!.value(forKey: "status") as? Int
                    {
                        if JsonResult == 200
                        {
                            
                            delegate?.didFinishedWithData!(json!)
                            
                        }
                        else
                        {
                            let JsonResultMessage = json!.value(forKey: "message") as! String
                            
                            delegate?.didFinishedWithError!(JsonResultMessage)
                        }
                        
                    }
                    else
                    {
                        delegate?.didFinishedWithError!("Server Error")
                    }
                }
                catch
                    
                {
                    delegate?.didFinishedWithError!("Api Error")
                    print("Something went wrong")
                    
                }
            }
            break
        case .enApiGetCustomer:
            if let data = response.data(using: String.Encoding.utf8) {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data,
                                                                options: .mutableContainers) as? NSMutableDictionary
                    print(json!.value(forKey: "message") as! String)
                    if let JsonResult = json!.value(forKey: "status") as? Int
                    {
                        if JsonResult == 200
                        {
                            
                            delegate?.didFinishedWithData!(json!)
                            
                        }
                        else
                        {
                            let JsonResultMessage = json!.value(forKey: "message") as! String
                            
                            delegate?.didFinishedWithError!(JsonResultMessage)
                        }
                        
                    }
                    else
                    {
                        delegate?.didFinishedWithError!("Server Error")
                    }
                }
                catch
                    
                {
                    delegate?.didFinishedWithError!("Api Error")
                    print("Something went wrong")
                    
                }
            }
            break
            
        default:
            print("end")
        }
        
        
    }
  
    
    func communicationManagerErrorOccurred(_ error: String) {
        
        
        delegate?.didFinishedWithError!(error)
        
    }
    
}
