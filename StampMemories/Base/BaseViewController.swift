//
//  BaseViewController.swift
//  Ugurcan
//
//  Created by Arshdeep Kaur on 08/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
//import SlideMenuControllerSwift
import GoogleSignIn
import SVProgressHUD
import SlideMenuControllerSwift

class BaseViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func navigateToHomeScreen()
    {
        let userdef =  UserDefaults()
        userdef.removeObject(forKey: userLoggedInKey)
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        let navigationController =  UINavigationController.init(rootViewController: loginViewController!)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.window?.rootViewController =  navigationController
        
    }
    func navigateToDashBoard()
    {
        let dasboardviewController = UIStoryboard(name: "DashBoardStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ActivityAndExperienceViewController") as? ActivityAndExperienceViewController
        
        
        
        let leftMenuView = UIStoryboard(name: "DashBoardStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController
        
        let navigationController =  UINavigationController.init(rootViewController: dasboardviewController!)
        
        
        let slideMenuViewController = SlideMenuController(mainViewController: navigationController , leftMenuViewController: leftMenuView!)
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.window?.rootViewController =  slideMenuViewController
    }
    func setRightBarButtonItem()
    {
           self.addRightBarButtonWithImage(UIImage(named: "filter")!)
    }
    func setNavigationBarItem() {
        
        self.addLeftBarButtonWithImage(UIImage(named:"Menu" )!)
        
      
        self.slideMenuController()?.removeLeftGestures()
        //self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        // self.slideMenuController()?.addRightGestures()
    }
    //MARK: -  Progress HUD
    
    func showProgressView() {
        SVProgressHUD.setDefaultMaskType(.black)
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func showProgressViewWith(message:String) {
        SVProgressHUD.setDefaultMaskType(.black)
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    func hideProgressView()  {
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                    GIDSignIn.sharedInstance().delegate = self
                    GIDSignIn.sharedInstance().uiDelegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
//    //MARK: - Cache & Show Image
//
//    func cacheAndShowProfileImage(imageUrl:String, imageView:UIImageView, loadingIndicator:UIActivityIndicatorView) {
//        printCustom(message: "Download Image:\(imageUrl)")
//        if !imageUrl.isEmpty {// If image url exists.
//            if let img = imageCache[imageUrl] {// If image exists in cache.
//                // Show image from cache.
//                imageView.image = img
//                imageView.accessibilityIdentifier = ""
//            }
//            else if imageCache[imageUrl] == nil {
//                // Start loader.
//                loadingIndicator.startAnimating()
//
//                // Downloading answer media image.
//                URLSession.shared.dataTask(with: URL(string: imageUrl)!, completionHandler: { (data, response, error) -> Void in
//
//                    // If error comes.
//                    if error != nil {
//                        DispatchQueue.main.async {
//                            // Stop loader.
//                            loadingIndicator.stopAnimating()
//
//                            // Show no image - placeholder image.
//                            imageView.image = CommonFunctions.getUserProfile().gender == kGirlId ? UIImage(named: imageBabyGirlPlaceholder): UIImage(named: imageBabyBoyPlaceholder)
//                            imageView.accessibilityIdentifier = kNoImage
//
//                            // Image Placeholder Color
//                            //self.changeImageViewTintColor(imgVw:imageView)
//                        }
//
//                        printCustom(message: "error in image:\(String(describing: error))")
//                        return
//                    }
//
//                    DispatchQueue.main.async {
//                        // Stop loader.
//                        loadingIndicator.stopAnimating()
//
//                        // Create image from downloaded image data.
//                        let image = UIImage(data: data!)
//
//                        // If image doesnot exists.
//                        if image == nil {
//                            // Show no image - placeholder image.
//                            imageView.image = CommonFunctions.getUserProfile().gender == kGirlId ? UIImage(named: imageBabyGirlPlaceholder): UIImage(named: imageBabyBoyPlaceholder)
//                            imageView.accessibilityIdentifier = kNoImage
//
//                            // Image Placeholder Color
//                            //self.changeImageViewTintColor(imgVw:imageView)
//                        }
//                        else {
//                            // Show downloaded image.
//                            imageView.image = image
//                            imageView.accessibilityIdentifier = ""
//
//                            // Save image in cache.
//                            imageCache[imageUrl] = image
//                        }
//                    }
//                }).resume()
//            }
//        }
//        else {
//            // Show no image - placeholder image.
//            imageView.image = CommonFunctions.getUserProfile().gender == kGirlId ? UIImage(named: imageBabyGirlPlaceholder): UIImage(named: imageBabyBoyPlaceholder)
//            imageView.accessibilityIdentifier = kNoImage
//
//            // Image Placeholder Color
//            //self.changeImageViewTintColor(imgVw:imageView)
//        }
//    }
//
    // MARK: - Show Alert
    
    func showCommonAlert(msg:String) {
        let alert:UIAlertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: alertBtnTitleOK, style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showCommonAlertAndNavigateBack(msg:String) {
        let alert:UIAlertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: alertBtnTitleOK, style: .default, handler: { (UIAlertAction) -> Void in
            self.navigateBack()
        })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func navigateToHomeScreen() {
//        let dashBoardViewController = UIStoryboard.loadDashBoardViewController()
//
//        let leftMenuView =  UIStoryboard.loadLeftMenuViewController()
//
//        let navigationController =  UINavigationController.init(rootViewController: dashBoardViewController)
//
//
//        let slideMenuViewController = SlideMenuController(mainViewController: navigationController , leftMenuViewController: leftMenuView)
//
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//
//        appdelegate.window?.rootViewController =  slideMenuViewController
//
//    }
    
    
    //MARK: - Sign In with Google
    func signInWithGoogle() {
        // Sign in with google
        GIDSignIn.sharedInstance().signIn()
    }
    
    func fetchGoogleProfile(dictProfile:NSDictionary) {
        print("dictProfile:\(dictProfile)")
    }
    
    //MARK: - Google Sign In Delegates
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let email = user.profile.email                  // For client-side use only!
            
            let firstName   = user.profile.givenName
            let lastName  = user.profile.familyName
            
            print("userID: \(String(describing: userId))")
            print("email: \(String(describing: email))")
         
            let resultDict = [emailKey: email, idKey: userId,firstNameKey:firstName,lastNameKey:lastName]
            self.successfullyRetreiveSocialProfile(response: resultDict as AnyObject, profileType: SocialProfileType.Google)
        } else {
            print("\(error.localizedDescription)")
            self.failedToRetreiveSocialProfile(response: alertFailedToFetchGoogleProfile as AnyObject, profileType: SocialProfileType.Google)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        self.failedToRetreiveSocialProfile(response: alertFailedToFetchGoogleProfile as AnyObject, profileType: SocialProfileType.Google)
    }
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        print("signInWillDispatch")
        // Hide Loader
        //...
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func successfullyRetreiveSocialProfile (response:AnyObject, profileType:SocialProfileType) {

    }
    
    func failedToRetreiveSocialProfile (response:AnyObject, profileType:SocialProfileType) {
        
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
