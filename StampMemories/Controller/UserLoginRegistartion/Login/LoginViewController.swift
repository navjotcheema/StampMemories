 //
//  LoginViewController.swift
//  StampMemories
 //  Created by Apple on 28/11/17.
 //  Copyright © 2017 Appvar All rights reserved.
//

import UIKit
import Reachability

class LoginViewController: BaseViewController,BusinessLayerDelegate,SocialUtilitiesDelegate {
    @IBOutlet weak var tf_Password: UITextField!
    @IBOutlet weak var tf_UserName: UITextField!
    @IBOutlet weak var btnChekBox: UIButton!
    var isLogInUsingSocialAccount = false
    var isSaveLogin =  false

    var socialAccountType:SocialProfileType?
    var socialUniqueId = ""
    var socialAccountEmail = ""
    var socialAccount = ""
    var socialAccountFirstName = ""
    var socialAccountLastName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults =  UserDefaults()
        var image = UIImage()
        if defaults.value(forKey: rememberedUsernameKey) != nil
        {
            
            isSaveLogin = true

            tf_Password.text = defaults.value(forKey: rememberedPasswordKey) as? String
            tf_UserName.text = defaults.value(forKey: rememberedUsernameKey) as? String
            image = (UIImage(named:"checkbox_green_icn")?.withRenderingMode(.alwaysTemplate))!
            btnChekBox.tag =  1

        }
        else
        {
            isSaveLogin = false
            tf_Password.text = ""
            tf_UserName.text = ""
            image = (UIImage(named:"checkbox_icn")?.withRenderingMode(.alwaysTemplate))!

            
        }
        
        
        btnChekBox.setImage(image, for: .normal)
        btnChekBox.tintColor = UIColor(hexString:navBarColor)

       
        
        CommonFunctions.setTextFieldBorder(textfield: tf_UserName)
        CommonFunctions.setTextFieldBorder(textfield: tf_Password)

       
    }
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
    }
    @IBAction func btnForgotPassword(_ sender: UIButton) {
    }
    @IBAction func btnLoginAction(_ sender: UIButton) {
        isLogInUsingSocialAccount = false

         if tf_UserName.text == ""
        {
            showCommonAlert(msg: "Please enter Username")

        }
         else if tf_Password.text == ""
         {
            showCommonAlert(msg: "Please enter Password")
            
         }
        else
        {
            if  CommonFunctions().isValidEmail(email: tf_UserName.text!) == true
            {
              initiateLogin()
            }
            else
            
            {
                showCommonAlert(msg: "Please enter valid email")
            }
        }
    }

    
    func initiateLogin()
    {
        
        // Check internet availability
        if !Reachability()!.isReachable {
            // Show alert, if internet not available.
            showCommonAlert(msg: alertNoInternetConnection)
        }
        else {
            // Show Loader.
            showProgressView()

            // Prepare parameters.
            var socialId = ""
            var username = ""
            var password = ""
            var loginType = ""
            if !isLogInUsingSocialAccount {
                username = tf_UserName.text!
                password = tf_Password.text!
                socialId  = ""
               loginType = "custom"
            }
            else {
               username = socialAccountEmail
               socialId  = socialUniqueId
                loginType = "social"

            }
            
            var deviceTokenStr = ""
            let defaults =  UserDefaults()
            
            if defaults.value(forKey: "token") != nil
                
            {
                deviceTokenStr = defaults.value(forKey: "token") as! String
            }
            else
            {
                deviceTokenStr = "123456789qewqeqweqeqeqeq"
                
            }
            let bizLayer = BusinessLayer()
            bizLayer.delegate = self
            bizLayer.Login(email: username, password: password, devicetype: "ios", login_type:loginType , devicetoken:deviceTokenStr , social_id: socialId)
        }
       
      
        
    }

    func didFinishedWithError(_ errorMessage: String) {
        print(errorMessage)
        hideProgressView()
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            if errorMessage == "Social ID not registered"
            {
//                register_type:registerTypeKey ,
//                social_id:socialIdKey ,
//                social_type:socialTypeKey
                
             
                let registerView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
                registerView?.socialTypeKey =  self.socialAccount
                registerView?.socialIdKey =  self.socialUniqueId
                registerView?.registerTypeKey = "social"
               registerView?.strFirstName = self.socialAccountFirstName
               registerView?.strLastName = self.socialAccountLastName
               registerView?.strEmail = self.socialAccountEmail
            
            self.navigationController?.pushViewController(registerView!, animated: true)
                
            }
            else
            {
                self.showCommonAlert(msg: errorMessage)
                
            }
            
        })
    }
    func didFinishedWithData(_ responseMessage: NSMutableDictionary) {
        print(responseMessage)
        
        hideProgressView()
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {

            let responseData = responseMessage.value(forKey: "data") as! [String:Any]
            
            let userDetails =  User()
            
            userDetails.account_id =  CommonFunctions().nullToNil(value:responseData["account_id"] as? String )!
           
            
            userDetails.api_token = CommonFunctions().nullToNil(value:responseData["api_token"] as? String )!
            userDetails.credit_card_token = CommonFunctions().nullToNil(value:responseData["credit_card_token"] as? String )!

         userDetails.bio = CommonFunctions().nullToNil(value:responseData["userDetails.bio"] as? String )!

      userDetails.api_token = CommonFunctions().nullToNil(value:responseData["userDetails.api_token"] as? String )!

            userDetails.business_name = CommonFunctions().nullToNil(value:responseData["business_name"] as? String )!


            userDetails.country_code = CommonFunctions().nullToNil(value:responseData["country_code"] as? String )!
            
            userDetails.customer_id = CommonFunctions().nullToNil(value:responseData["customer_id"] as? String )!
            
            userDetails.devicetoken = CommonFunctions().nullToNil(value:responseData["devicetoken"] as? String )!
            
            
            userDetails.devicetype = CommonFunctions().nullToNil(value:responseData["devicetype"] as? String )!
            
            userDetails.email = CommonFunctions().nullToNil(value:responseData["email"] as? String )!
            userDetails.firstname = CommonFunctions().nullToNil(value:responseData["firstname"] as? String )!
            userDetails.id = CommonFunctions().nullToNil(value:responseData["id"] as? String )!
            userDetails.is_provider = CommonFunctions().nullToNil(value:responseData["is_provider"] as? String )!
            userDetails.lastname = CommonFunctions().nullToNil(value:responseData["lastname"] as? String )!
            userDetails.latitude = CommonFunctions().nullToNil(value:responseData["latitude"] as? String )!
            userDetails.locale = CommonFunctions().nullToNil(value:responseData["locale"] as? String )!
            userDetails.location = CommonFunctions().nullToNil(value:responseData["location"] as? String )!
            userDetails.longitude = CommonFunctions().nullToNil(value:responseData["longitude"] as? String )!
            userDetails.mobile_verified = CommonFunctions().nullToNil(value:responseData["mobile_verified"] as? String )!
            userDetails.phone = CommonFunctions().nullToNil(value:responseData["phone"] as? String )!
            userDetails.profile_image = CommonFunctions().nullToNil(value:responseData["profile_image"] as? String )!
            userDetails.profile_url = CommonFunctions().nullToNil(value:responseData["profile_url"] as? String )!
            userDetails.provider = CommonFunctions().nullToNil(value:responseData["provider"] as? String )!
            userDetails.provider_id = CommonFunctions().nullToNil(value:responseData["provider_id"] as? String )!
            userDetails.representative_first_name  = CommonFunctions().nullToNil(value:responseData["representative_first_name"] as? String )!
            userDetails.representative_last_name = CommonFunctions().nullToNil(value:responseData["representative_last_name"] as? String )!
            userDetails.slug = CommonFunctions().nullToNil(value:responseData["slug"] as? String )!
            userDetails.social_id = CommonFunctions().nullToNil(value:responseData["social_id"] as? String )!
            userDetails.social_type  = CommonFunctions().nullToNil(value:responseData["social_type"] as? String )!
            userDetails.status = CommonFunctions().nullToNil(value:responseData["status"] as? String )!
            userDetails.user_type = CommonFunctions().nullToNil(value:responseData["user_type"] as? String )!
  
            CommonFunctions.setUserProfile(user: userDetails)
            
            
            
            let userdef =  UserDefaults()
            userdef.set("LoggedIn", forKey: userLoggedInKey)
            if self.isSaveLogin == true
            {
            userdef.set(self.tf_UserName.text, forKey: rememberedUsernameKey)
            userdef.set(self.tf_Password.text, forKey: rememberedPasswordKey)
            }
            else
                {
                    userdef.removeObject(forKey: rememberedUsernameKey)
                    userdef.removeObject(forKey: rememberedPasswordKey)

            }
            userdef.synchronize()
            //self.showCommonAlert(msg: "Logged In Successfully")
            self.navigateToDashBoard()
            
        })
    }
   
    
    @IBAction func btnCheckBoxClicked(_ sender: UIButton) {
        if sender.tag == 0
        {
            
             isSaveLogin =  true

            btnChekBox.tag = 1

                let image = UIImage(named:"checkbox_green_icn")?.withRenderingMode(.alwaysTemplate)
                btnChekBox.setImage(image, for: .normal)
                
            
            
            
        }
        else
        {
           
                btnChekBox.tag = 0
            isSaveLogin =  false
           let image = UIImage(named:"checkbox_icn")?.withRenderingMode(.alwaysTemplate)
                btnChekBox.setImage(image, for: .normal)
            
        }
        
    }
    
    @IBAction func btnLoginWithFacebookClicked(_ sender: Any) {
        let socialUtilities: SocialUtilities = SocialUtilities()
        socialUtilities.delegate = self as SocialUtilitiesDelegate
        socialUtilities.signInWithFacebook(fromViewController: self)
    }
    
    @IBAction func btnLoginWithGooglePlusClicked(_ sender: Any) {
        self.signInWithGoogle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Social Utilities Delegates
    
    override func successfullyRetreiveSocialProfile (response:AnyObject, profileType:SocialProfileType) {
        isLogInUsingSocialAccount = true
        
        print("successfullyRetreiveSocialProfile: \(response) forProfileType:\(profileType.rawValue)");
        
        let resultDict = response as! NSDictionary
        let email = resultDict[emailKey] as! String
        let socialMediaID = resultDict[idKey] as! String
        let firstName = resultDict[firstNameKey] as!String
        let lastName = resultDict[lastNameKey] as!String

        socialAccountEmail = email
        socialUniqueId = socialMediaID
        socialAccount = String(describing: profileType)
        socialAccountFirstName  = firstName
        socialAccountLastName = lastName
        print(profileType)
        initiateLogin()
    }
    
    override func failedToRetreiveSocialProfile (response:AnyObject, profileType:SocialProfileType) {
        print("failedToRetreiveSocialProfile: \(response) forProfileType:\(profileType.rawValue)");
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
