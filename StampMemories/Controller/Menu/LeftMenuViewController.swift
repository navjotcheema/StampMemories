//
//  LeftMenuViewController.swift
//  Ugurcan
//
//  Created by Apple on 26/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit



class LeftMenuViewController: BaseViewController {
    
   
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var userName : UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    //let blueColor = UIColor(hexString:"#0D1554" )
    
    
    @IBOutlet weak var tableLeftmenu: UITableView!
    
var customerDashboardArray = ["Home","Settings","Purchases","Funds","Communication","Switch To Provider","Invite a Friend","LogOut"]
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     userName.text =  CommonFunctions.getUserProfile().firstname +
    CommonFunctions.getUserProfile().lastname
        
        companyNameLabel.text = CommonFunctions.getUserProfile().business_name
        tableLeftmenu.backgroundColor =  UIColor.black
        
        tableLeftmenu.tableFooterView =  UIView()
        tableLeftmenu.separatorStyle =  UITableViewCellSeparatorStyle.singleLine
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
    func changVieCOntroller(indexPath:Int)
    {
//       let storyBoard : UIStoryboard = UIStoryboard(name: "DashboardStoryboard", bundle:nil)
//    let HealthStoryBoard : UIStoryboard = UIStoryboard(name: "HealthTipAndLab", bundle:nil)
//        let blogStoryBoard :UIStoryboard  = UIStoryboard(name:"BlogAndCafe", bundle: nil)

        switch indexPath {
        case 0:

            print(indexPath)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//
//            let mainView  = UINavigationController(rootViewController: nextViewController)
//            self.slideMenuController()?.changeMainViewController(mainView, close: true)

            print("start")
        case 1:
           
            print("start")
        case 2:
            print("start")

        case 3:
           
            print(indexPath)

        case 4:
           
            print("start")
        case 5:
           
            print("start")
        case 6:
          
            print(indexPath)

        case 7:
            navigateToHomeScreen()
        
        default:
            print("end")
    }
    }
    
    
//    func navigateToLoginScreen()  {
//
////        let  userdef =  UserDefaults.standard
////        userdef.set("NotLogedIn", forKey: "User")
////        userdef.set("", forKey:"user_id")
//
//        let storyBoard =  UIStoryboard(name:"Main", bundle:nil)
//        let loginView = storyBoard.instantiateViewController(withIdentifier: "ViewController")
//
//        appDelegate.window?.rootViewController = loginView
//    }
}
extension LeftMenuViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerDashboardArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! LeftMenuTableViewCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectedBackgroundView = backgroundView
        if indexPath.row == 5
        {
            print(CommonFunctions.getUserProfile().is_provider)
            if CommonFunctions.getUserProfile().is_provider == "yes"
            {
                cell.lbl_Type.text = "Switch To Provider"

            }
            else
            {
                cell.lbl_Type.text = "Become Provider"

            }
        }
        else
        {
        cell.lbl_Type.text = customerDashboardArray[indexPath.row]
        }
cell.backgroundColor =  UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let row =  indexPath.row
        
       changVieCOntroller(indexPath: row)
    
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor  = UIColor.clear
    }
    
    
}
extension UIImageView
{
    func blurrEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(blurEffectView)
    }
}
