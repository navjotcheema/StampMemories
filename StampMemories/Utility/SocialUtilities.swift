//
//  SocialUtilities.swift
//  SampleSocialIntegration
//
//  Created by Arshdeep on 11/09/17.
//  Copyright © 2017 Arshdeep. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol SocialUtilitiesDelegate {
    func successfullyRetreiveSocialProfile (response:AnyObject, profileType:SocialProfileType)
    func failedToRetreiveSocialProfile (response:AnyObject, profileType:SocialProfileType)
}

class SocialUtilities: NSObject {
    var delegate:SocialUtilitiesDelegate! = nil
    let alertErrorConnectingTwitter = "Error Connecting Twitter. Try again"
    var viewControllerToPresent:UIViewController?

    // MARK: - Login & Fetch Facebook Profile
    func unlinkFacebookAccount(fromViewController:UIViewController){
        if FBSDKAccessToken.current() != nil {
            let facebookLogin = FBSDKLoginManager()
            facebookLogin.logOut()
            print("FBSDKAccessToken.currentAccessToken():\(FBSDKAccessToken.current())")
        }
        
    }
    func signInWithFacebook(fromViewController:UIViewController) {
        if FBSDKAccessToken.current() != nil {
            self.fetchFacebookProfile()
        }
        else {
            let facebookLogin = FBSDKLoginManager()
            facebookLogin.logIn(withReadPermissions: ["email"],  from: fromViewController) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: Error!) -> Void in
                if !facebookResult.isCancelled {
                    self.fetchFacebookProfile()
                }
                else {
                    print("Cancelled fetching facebook profile")
                    self.delegate.failedToRetreiveSocialProfile(response: "Cancelled fetching facebook profile" as AnyObject, profileType: SocialProfileType.Facebook)
                }
            }
        }
    }
    
    func fetchFacebookProfile() {
        //Show Loader
        //....
        
        // Fetch profile
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, email,first_name,last_name"]).start(completionHandler: { (connection, result, error) -> Void in
            //Hide Loader
            //....
            
            if (error == nil){
                
                let resultDict = result as! NSDictionary
                
                print("profile:\(resultDict)")
                
                let email = resultDict[emailKey] as! String
                let socialMediaID = resultDict[idKey] as! String
                
                print("profile email:\(email)")
                print("profile socialMediaID:\(socialMediaID)")
                
                self.delegate.successfullyRetreiveSocialProfile(response: resultDict, profileType: SocialProfileType.Facebook)
            }
            else {
                print("Failed to fetch facebook profile")
                self.delegate.failedToRetreiveSocialProfile(response: alertFailedToFetchFacebookProfile as AnyObject, profileType: SocialProfileType.Facebook)
            }
            
        })
    }
    

    
    func hideLoaderConnectingTwitter() {
        //Hide Loader
        //....
    }
   

}
