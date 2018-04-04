//
//  CommManager.swift
//  NODAT
//
//  Created by NavdeepSingh on 28/02/17.
//  Copyright © 2017 Trantor Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol commManagerDelegate
    
{
    func communicationManagerDidFinish(_ response:String)
    func communicationManagerErrorOccurred(_ error:String)
    func communicationManagerDidFinishGet(_ response:NSMutableDictionary)
}

class CommManager: NSObject {
    
    
    var delegate:commManagerDelegate?
    
    
    
    //Mark :- Receive Params
    
    func receiveParams(_ postParams:[String:Any],urlStr:String)
    {
        
        do {
            let jsonData =  try JSONSerialization.data(withJSONObject: postParams, options: JSONSerialization.WritingOptions())
            //print(postParams)
            
            
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            print(jsonString)
            print(urlStr)
            self.postRequest(urlStr,
                             withParams:postParams as! [String : Any])
            {
                (succeeded: Bool, msg: String) -> () in
                if(succeeded) {
                    if msg == "0"
                    {
                        print("not found")
                        
                        //Incorrect data...
                        
                        self.delegate?.communicationManagerErrorOccurred(msg)
                    }
                    else
                    {
                        print(msg)
                        self.delegate?.communicationManagerDidFinish(msg)
                        
                    }
                }
                else
                {
                    self.delegate?.communicationManagerErrorOccurred(msg)
                }
            }
        }
        catch {
            self.delegate?.communicationManagerErrorOccurred("Server not responding")
            print("bad things happened")
        }
        
        
        
    }
    
    func getAPIRequest(urlStr:String)
        
    {
        print(urlStr)
        if let url = URL(string:urlStr)
        {
            
            URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if(error != nil){
                    print("error")
                    self.delegate?.communicationManagerErrorOccurred("Server not responding")

                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!,
                                                                    options: .mutableContainers) as? NSMutableDictionary
                        self.delegate?.communicationManagerDidFinishGet(json!)
                        
                        OperationQueue.main.addOperation({
                        })
                        
                    }catch let error as NSError{
                        
                        print(error)
                        self.delegate?.communicationManagerErrorOccurred(error.localizedDescription)
                        
                    }
                }
            }).resume()
        }
    }
    
    //Mark:- NSURL Session
    
    func postRequest(_ url:String, withParams params:[String:Any], postCompleted : @escaping (_ succeeded: Bool, _ msg: String) -> ()){
        print(url)
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 120.0)
        
        let session = URLSession.shared
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let _: NSError?
        
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params , options: JSONSerialization.WritingOptions.init(rawValue: 2))
            print("Done")
        }
        catch {
            // Error Handling
            
            print("Error")
            
        }
        
        
        let task =  session.dataTask(with:request) { (data,response,err) in
            if err != nil
            {
                
                postCompleted(false, "Data not found!")
            }
            else
            {
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            postCompleted(true, dataString! as String)
            }
        }
        task.resume()
        
        
        
    }
    
    
    
    //Mark :-  Alamofire Sessions
    class func postApi(_ parametersStr:[String : String], UrlStr: String, completionHandler: @escaping (JSON?, String?) -> ()) ->Void
    {
        do {
            
            // TODO: handle no network
            
            let valid = JSONSerialization.isValidJSONObject(parametersStr) // true
            print(valid)
            let jsonData =  try JSONSerialization.data(withJSONObject: parametersStr, options: .prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            print("Parameters JSON:\(jsonString)")
            
            
            let parameters: Parameters = parametersStr
            //print(parametersStr)
            
            /*let headers: HTTPHeaders = [
             "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
             "Accept": "application/json"
             ]*/
            
            let headers = ["Content-Type": "application/json"]
            Alamofire.request(UrlStr, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let value):
                    let json = JSON(value)
                    print("Response JSON: \(json)")
                    if json != JSON.null {
                        completionHandler(json as JSON?, nil)
                        
                    }
                    else {
                        completionHandler(JSON.null, "error occured")
                        
                    }
                    
                case .failure(let error):
                    print("Error : \(error.localizedDescription)")
                    completionHandler(JSON.null, error.localizedDescription)
                    
                }
            }
            
        }
        catch
        {

            print("error occured while making api call")
        }
    }
    
}
