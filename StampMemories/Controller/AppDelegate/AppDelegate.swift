//  AppDelegate.swift
//  StampMemories
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.


import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import UserNotifications
import FBSDKCoreKit
import GoogleSignIn
import SlideMenuControllerSwift

// Shared App Delegate

let sharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func checkUserLoggedIn()
    {
//        let userDef =  UserDefaults()
//        if userDef.value(forKey: userLoggedInKey) != nil
//        {
//navigateToDashBoard()
//        }
//        else
//        {
//            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
//            
//            let navigationController =  UINavigationController.init(rootViewController: loginViewController!)
//            self.window?.rootViewController = navigationController
//
//            
//            
//        }
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        let navigationController =  UINavigationController.init(rootViewController: loginViewController!)
        self.window?.rootViewController = navigationController
        
    }
    func navigateToDashBoard()
    {
        let dasboardviewController = UIStoryboard(name: "DashBoardStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ActivityAndExperienceViewController") as? ActivityAndExperienceViewController
        
        
        
        let leftMenuView = UIStoryboard(name: "DashBoardStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController
        
        let navigationController =  UINavigationController.init(rootViewController: dasboardviewController!)
        
        
        let slideMenuViewController = SlideMenuController(mainViewController: navigationController , leftMenuViewController: leftMenuView!)
        
        
        self.window?.rootViewController =  slideMenuViewController
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        checkUserLoggedIn()
        IQKeyboardManager.sharedManager().enable = true
        setNavigationBar()
        registerForPushNotifications()
        GIDSignIn.sharedInstance().clientID = googleOauthClientId

    GMSPlacesClient.provideAPIKey("AIzaSyCAkvyffO8VKToUWXEe21ggHD9a0h_hXLA")
        
   // GMSServices.provideAPIKey("AIzaSyCAkvyffO8VKToUWXEe21ggHD9a0h_hXLA")
        
        // Override point for customization after application launch.
        // Facebook Initialization
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        
        let defaults =  UserDefaults()
        defaults.set(token, forKey: "token")
        defaults.synchronize()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    //MARK: - Handle Open URL
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        // Google Sign In
        if GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]) {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        
        
        // Facebook
        let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: nil)
    }
    func setNavigationBar() {
        //UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        UINavigationBar.appearance().isTranslucent = true
        
        UINavigationBar.appearance().alpha = 0.5
        
CommonFunctions().changeNavBarColor()
        
        // these next lines aren't needed if you like the default
        
        let navbarFont = UIFont(name: "Comic Sans MS", size: 22) ?? UIFont.systemFont(ofSize: 17)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: navbarFont, NSAttributedStringKey.foregroundColor:UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

