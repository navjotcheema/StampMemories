//
//  RegisterViewController.swift
//  StampMemories
//
//  Created by Apple on 28/11/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import RMPickerViewController
import GooglePlaces


class RegisterViewController: BaseViewController,UITextFieldDelegate,BusinessLayerDelegate{
    
    //Social Checks
    var registerTypeKey = ""
    var socialIdKey = ""
    var socialTypeKey = ""
    
    //
    var serviceType =  0
    var userType = 0
    var roleId =  0
    var strLatitude   = ""
    var strLongitude = ""
    var codePicker:UIPickerView = UIPickerView()
    var businessRoleArray = [[String:Any]]()
    var individualRole = [String:Any]()
    var strlocation = ""
    var countryDialCode =  ""
    var countryImageName =  String()
    var strFirstName =  ""
    var strLastName  =  ""
    var strEmail =  ""
    var countryCodeArr = [[String:AnyObject]]()
    var countryImageArr =  [String]()
    let toolBar = UIToolbar()

    var messageTiitle = ""

    var selectedServiceValue =  ""
    var selectedUserValue =  ""
    var selectedRoleValue = ""
    var selectType =  0
    @IBOutlet weak var regTableView: UITableView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var arrayUserType = ["individual","business"]
    var arrayServiceType =  ["customer","provider"]
    
    var arrayOfCellIdentifier = ["cellServiceType","cellUserType","cellBusinessName","cellRepresentativeFirstName","cellLastName","cellRole","cellMobile","cellEmail","cellLocation","cellPassword","cellConfirmPassword"]
    
    
    var arrayOfTextFieldNames : [String] = [String]()
    var rowBeingEdited : Int? = nil
    
    
    
   
   func googlePlace()
   {
    let autocompleteController = GMSAutocompleteViewController()
    autocompleteController.delegate = self
    present(autocompleteController, animated: true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryDialCode = "+1"
        if registerTypeKey == ""
        {
            registerTypeKey = "custom"
        }
        else
        {
            
        }
        regTableView.tableFooterView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title:"Register", style: .plain, target: self, action: #selector(registerButtonTapped))
       // regTableView.separatorStyle = .none
        
        self.title  = "Registration"
        getCountryCode()
    }
    @objc func registerButtonTapped(){
      
      
        let cell:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! customTableViewCell
    
        
        let cellUserType:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 1, section: 0) as IndexPath) as! customTableViewCell
        
        let cellBusinesType:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 2, section: 0) as IndexPath) as! customTableViewCell
        
        let cellRepFName:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 3, section: 0) as IndexPath) as! customTableViewCell
        
        let cellRepLastName:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 4, section: 0) as IndexPath) as! customTableViewCell
        
        let cellRole:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 5, section: 0) as IndexPath) as! customTableViewCell
        
        let cellCode:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 6, section: 0) as IndexPath) as! customTableViewCell
        
        
        let cellMobileNo:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 6, section: 0) as IndexPath) as! customTableViewCell
        
        let cellEmail:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 7, section: 0) as IndexPath) as! customTableViewCell
        
        let cellLocation:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 8, section: 0) as IndexPath) as! customTableViewCell
        
        let cellPassword:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 9, section: 0) as IndexPath) as! customTableViewCell
       
        let cellConfirmPas:customTableViewCell = regTableView.cellForRow(at: NSIndexPath(row: 10, section: 0) as IndexPath) as! customTableViewCell
        
        if userType == 0
        {
         
            
            let firstName =  cellRepFName.tf_FirstName.text!
    let lastName = cellRepLastName.tfLastName.text!
           
            
            indiVidualUser(firstname:firstName, lastname: lastName, country_code: cellCode.tfCode.text!, phone: cellMobileNo.tfMobileNo.text!, email: cellEmail.tfEmail.text!, password: cellPassword.tfPassword.text!, confirmPasswod:cellConfirmPas.tfConfirmPassword.text!, user_service_type:cell.tf_UserServiceType.text!,userType:cellUserType.tf_SelectUserType.text!,locationStr:cellLocation.tfLocation.text!)
        }
        else
        {
           
            let  repFirstName =  cellRepFName.tf_FirstName.text!
            let repLastNameName = cellRepLastName.tfLastName.text!
            let roleName = cellRole.tf_Role.text!
            let businessName = cellBusinesType.tfBusinessName.text!
            
            BusinessUser(firstname:"", lastname: "", business_name:cellBusinesType.tfBusinessName.text!, representative_first_name:repFirstName, representative_last_name: repLastNameName, role_id:roleName, country_code: cellCode.tfCode.text!, phone: cellMobileNo.tfMobileNo.text!, email: cellEmail.tfEmail.text!, password: cellPassword.tfPassword.text!, confirmPasswod:cellConfirmPas.tfConfirmPassword.text!, user_service_type:cell.tf_UserServiceType.text!,userType:cellUserType.tf_SelectUserType.text!,locationStr:cellLocation.tfLocation.text!)
        }
     
        
    }
    
    func indiVidualUser(firstname: String, lastname: String,    country_code: String, phone: String, email: String, password: String, confirmPasswod:String, user_service_type:String,userType:String,locationStr :String)
    {
        if user_service_type == ""
        {
            self.showCommonAlert(msg: "Please select user service type")
            
            
        }
        else if userType == ""
        {
            self.showCommonAlert(msg: "Please select user type")
            
        }
            
        else if firstname == ""
        {
            self.showCommonAlert(msg: "PLease enter First Name")
            
        }
            
        else if lastname == ""
        {
            self.showCommonAlert(msg: "Please enter Last Name")
            
        }
            
        else if country_code == ""
        {
            self.showCommonAlert(msg: "Please enter Country Code")
            
        }
        else if phone == ""
        {
            self.showCommonAlert(msg: "Please enter Mobile No")
            
        }
        else if email == ""
        {
            self.showCommonAlert(msg: "Please enter Email")
            
        }
            
        else if  CommonFunctions().isValidEmail(email:  email) == true
        {
            
            
            
            if locationStr == ""
            {
                self.showCommonAlert(msg: "Please enter Location")
                
                
            }
               if registerTypeKey == "social"
               {
                let defaults =  UserDefaults()
                var deviceTokenStr = ""
                if defaults.value(forKey: "token") != nil
                {
                    deviceTokenStr =  defaults.value(forKey: "token") as! String
                }
                else
                {
                    deviceTokenStr = "1398712971971937979771313"
                    
                }
                registerUser(firstname: firstname,
                             lastname:lastname,
                             business_name:"" ,
                             representative_first_name:"" ,
                             representative_last_name:"" ,
                             role_id:"",
                             country_code: country_code,
                             phone:phone ,
                             email:email ,
                             password:password ,
                             devicetype:"ios" ,                                 user_service_type:user_service_type ,
                             devicetoken:deviceTokenStr ,
                             latitude:strLatitude ,
                             longitude:strLongitude ,
                             location:strlocation ,
                             user_type: userType,
                             register_type:registerTypeKey ,
                             social_id:socialIdKey ,
                             social_type:socialTypeKey)
               }
                else
               {
                
                        if password == ""
                            {
                                self.showCommonAlert(msg: "Please enter Password")
                
                        }
                        else if confirmPasswod == ""
                        {
                
                            self.showCommonAlert(msg: "Please enter Confirm Password")
                
                        }
                        else
                        {
                            if password == confirmPasswod
                            {
                                let defaults =  UserDefaults()
                                var deviceTokenStr = ""
                                if defaults.value(forKey: "token") != nil
                                {
                        deviceTokenStr =  defaults.value(forKey: "token") as! String
                                }
                                else
                                {
                                    deviceTokenStr = "1398712971971937979771313"
                        
                                }
                                registerUser(firstname: firstname,
                                 lastname:lastname,
                                 business_name:"" ,
                                 representative_first_name:"" ,
                                 representative_last_name:"" ,
                                 role_id:"",
                                 country_code: country_code,
                                 phone:phone ,
                                 email:email ,
                                 password:password ,
                                 devicetype:"ios" ,                                 user_service_type:user_service_type ,
                                 devicetoken:deviceTokenStr ,
                                 latitude:strLatitude ,
                                 longitude:strLongitude ,
                                 location:strlocation ,
                                 user_type: userType,
                                 register_type:registerTypeKey ,
                                 social_id:socialIdKey ,
                                 social_type:socialTypeKey)
                    
                }
                else
                {
                    
                    self.showCommonAlert(msg: "Password missmatch")
                    
                }
            }
            }
        }
        else
            
        {
            self.showCommonAlert(msg: "Please enter valid Email")
            
            
        }
        
        
        
    }
    func BusinessUser(firstname: String, lastname: String, business_name:String, representative_first_name:String, representative_last_name: String, role_id:String, country_code: String, phone: String, email: String, password: String, confirmPasswod:String, user_service_type:String,userType:String,locationStr :String)
    {
        if user_service_type == ""
        {
            self.showCommonAlert(msg: "Please select Register as")
            
            
        }
        else if userType == ""
        {
            self.showCommonAlert(msg: "Please select are you a?")
            
        }
            else if business_name == ""
        {
            self.showCommonAlert(msg: "PLease enter Business Name")

        }
        else if representative_first_name == ""
        {
            self.showCommonAlert(msg: "PLease enter Representative First Name")
            
        }
            
        else if representative_last_name == ""
        {
            self.showCommonAlert(msg: "Please enter Last Name")
            
        }
            else if role_id == ""
        {
            showCommonAlert(msg: "Please select Role at the Company")
        }
     
        else if country_code == ""
        {
            self.showCommonAlert(msg: "Please enter Country Code")
            
        }
        else if phone == ""
        {
            self.showCommonAlert(msg: "Please enter Mobile No")
            
        }
        else if email == ""
        {
            self.showCommonAlert(msg: "Please enter Email")
            
        }
            
        else if  CommonFunctions().isValidEmail(email:  email) == true
        {
            
            let defaults =  UserDefaults()
            var deviceTokenStr = ""
            if defaults.value(forKey: "token") != nil
            {
                deviceTokenStr =  defaults.value(forKey: "token") as! String
            }
            else
            {
                deviceTokenStr = "1398712971971937979771313"
                
            }
            
            if locationStr == ""
            {
                self.showCommonAlert(msg: "Please enter Location")
                
                
            }
              if registerTypeKey == "social"
              {
                registerUser(firstname: firstname,
                             lastname:lastname,
                             business_name:business_name ,
                             representative_first_name:representative_first_name ,
                             representative_last_name:representative_last_name ,
                             role_id:String(roleId) ,
                             country_code: country_code,
                             phone:phone ,
                             email:email ,
                             password:password ,
                             devicetype:"ios" ,                                 user_service_type:user_service_type ,
                             devicetoken:deviceTokenStr ,
                             latitude:strLatitude ,
                             longitude:strLongitude ,
                             location:strlocation ,
                             user_type: userType,
                             register_type:registerTypeKey ,
                             social_id:socialIdKey ,
                             social_type:socialTypeKey )
              }
                else
              {
                
             if password == ""
            {
                self.showCommonAlert(msg: "Please enter Password")
                
            }
            else if confirmPasswod == ""
            {
                
                self.showCommonAlert(msg: "Please enter Confirm Password")
                
            }
            else
            {
                if password == confirmPasswod
                {
                   
                    registerUser(firstname: firstname,
                                 lastname:lastname,
                                 business_name:business_name ,
                                 representative_first_name:representative_first_name ,
                                 representative_last_name:representative_last_name ,
                                 role_id:String(roleId) ,
                                 country_code: country_code,
                                 phone:phone ,
                                 email:email ,
                                 password:password ,
                                 devicetype:"ios" ,                                 user_service_type:user_service_type ,
                                 devicetoken:deviceTokenStr ,
                                 latitude:strLatitude ,
                                 longitude:strLongitude ,
                                 location:strlocation ,
                                 user_type: userType,
                                 register_type:registerTypeKey ,
                                 social_id:socialIdKey ,
                                 social_type:socialTypeKey )
                    
                }
                else
                {
                    
                    self.showCommonAlert(msg: "Password missmatch")
                    
                }
                }
            }
            
        }
        else
            
        {
            self.showCommonAlert(msg: "Please enter valid Email")
            
            
        }
        
        
        
    }
    
    
func registerUser(firstname:String,lastname:String,business_name:String,representative_first_name:String,representative_last_name:String,role_id:String,country_code:String,phone:String,email:String,password:String,devicetype:String,user_service_type:String,devicetoken:String,latitude:String,longitude:String,location:String,user_type:String,register_type:String,social_id:String,social_type:String)
    {
        serviceType = 2

        
        showProgressView()
        var  bizLayer = BusinessLayer()
       bizLayer.delegate = self
        bizLayer.register(firstname: firstname,lastname: lastname,business_name:business_name,
                        representative_first_name:
                        representative_first_name,
                        representative_last_name: representative_last_name,
                        role_id: role_id,
                        country_code: country_code,
                        phone: phone,
                        email: email,
                        password: password,
                        devicetype: devicetype,
                        user_service_type: user_service_type,
                        devicetoken: devicetoken,
                        latitude: latitude,
                        longitude: longitude,
                        location: location,
                        user_type: user_type,
                        register_type: register_type,
                        social_id: social_id,
                        social_type: social_type)
        
        
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCountryCode()
    {
        
        if let urlPath = Bundle.main.url(forResource: "countryCodes", withExtension: "json") {

                do {
                    let jsonData = try Data(contentsOf: urlPath, options: .mappedIfSafe)
                if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: AnyObject] {
                    if let personArray = jsonDict["Country"] as? [[String: AnyObject]] {

                    countryCodeArr =  personArray
                        for dummyArr  in countryCodeArr
                        {
                            var code:String  =  dummyArr["code"] as! String
                            code =  code + ".png"
                            print(code)
                            
                            countryImageArr.append(code)
                        }
                        print(countryCodeArr[0])
                        print(countryImageArr[0])
                    }
                }
            }
                
            catch let jsonError {
                print(jsonError)
            }

        }
    }
   
    @objc func btnActionSelectRole(sender:UITextField)
    {
        selectType  = 3
        if businessRoleArray.count == 0
        {
        showCommonAlert(msg: "Please select User Service Type and User Type")
        }
        else
        {
        openPickerViewController(sender: sender)
        }
    }
    @objc func btnActionSelectServiceType(sender:UITextField)
    {
        selectType  = 1

        openPickerViewController(sender: sender)

    }
    @objc func OpenLocationView(sender:UITextField)
    {
            googlePlace()
    }
    @objc func btnActionSelectUserType(sender:UITextField)
    {
        selectType  = 2

        openPickerViewController(sender: sender)
    }
    
    @objc func countryCodePicker(sender : UITextField)
    {
        selectType = 4
        codePicker.delegate = self
        codePicker.dataSource = self
        sender.inputView = codePicker
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK:- Open RMPickerViewController
    func openPickerViewController(sender : UITextField)
    {
sender.resignFirstResponder()
        let style = RMActionControllerStyle.white
        let lastSelectedIndex = 0
        
        let selectAction = RMAction<UIPickerView>(title: "Select", style: .done) { controller in
            var selectedRow = -1
            for component in 0 ..< controller.contentView.numberOfComponents {
                selectedRow = controller.contentView.selectedRow(inComponent: component)
                switch  sender.tag
                {
                case 101:
                     self.selectType  = 1
                    self.selectedServiceValue =  self.arrayServiceType[selectedRow]
                    self.getRoleType(roleType: self.selectedServiceValue)
                    self.regTableView.reloadData()

                case 102:
                    self.selectType  = 2

                    self.selectedUserValue =  self.arrayUserType[selectedRow]
                    self.regTableView.reloadData()
                    
                case 106:
                    self.selectType  = 3

                    if self.selectedUserValue == "business"
                    {
                        self.selectedRoleValue =  self.businessRoleArray[selectedRow]["description"] as! String
                        self.roleId = self.businessRoleArray[selectedRow]["id"] as! Int
                        self.regTableView.reloadData()
                    }
                    else
                    {

                        self.selectedRoleValue =  self.individualRole ["description"] as! String
                        self.roleId = self.individualRole["id"] as! Int

                        self.regTableView.reloadData()
                    }
                 

                default:
                    print("done")
                }
               
                }
                
                
                
                
                
            }
        
            
        
        let cancelAction = RMAction<UIPickerView>(title:"Cancel", style: .cancel) { _ in
            print("Row selection was canceled")
        }
        switch sender.tag {
        case 101:
            messageTiitle = "Please select service type"
        case 102:
            messageTiitle = "Please select user type"
        case 106:
            messageTiitle = "Please select Role"
        default:
            print("End")
        }
        
        let actionController = RMPickerViewController(style: style, title: messageTiitle, message: nil, select: selectAction, andCancel: cancelAction)!;
        
        actionController.disableBlurEffects = true
        actionController.picker.delegate = self
        actionController.picker.dataSource = self
        actionController.picker.selectRow(lastSelectedIndex, inComponent: 0, animated: true)
//        sender.inputView = UIView()

        present(actionController, animated: true, completion: nil)
        
    }
    
    
    //MARK:- GetRoleType
    func getRoleType(roleType:String)
    {
        serviceType = 1
        print(roleType)
        let bizLayer =  BusinessLayer()
        bizLayer.delegate = self

        showProgressView()
        if roleType == "loginType = "
        {
            
            bizLayer.getCustomer()
            
        }
        else
        
        {
            bizLayer.getProvider()

        }
    }
    //MARK:- Convert city in to LatLong
    
    func convertAddressIntoLatLong(address:String)
    {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let locationLat = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            print(locationLat.coordinate.latitude)
            print(locationLat.coordinate.longitude)
            self.strLatitude  =  String(locationLat.coordinate.latitude)
            self.strLongitude =  String(locationLat.coordinate.longitude)
            // Use your location
        }
        
    }
    
    //MARK:- BusinessLayer Delegate Methods
    func didFinishedWithError(_ errorMessage: String) {
        print(errorMessage)
        hideProgressView()
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.showCommonAlert(msg: errorMessage)
        })
    }
    func didFinishedWithData(_ responseMessage: NSMutableDictionary) {
        print(responseMessage)
        
        hideProgressView()
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            
            if  self.serviceType == 1
           {
            if self.businessRoleArray.count > 0
            {
                self.businessRoleArray.removeAll()

                self.individualRole.removeAll()
                
            }
            var responseData =  responseMessage.value(forKey: "data") as! [String:Any]
            
            print(responseData)
            self.businessRoleArray = responseData["business"] as! [[String:Any]]
            self.individualRole = responseData["individual"] as! [String:Any]
            
            print(self.businessRoleArray)
            print(self.individualRole)
            self.serviceType = 0
            }
           else if self.serviceType == 2
           {
            
            self.serviceType =  0
            self.showCommonAlert(msg: "Registered In Successfully")

               self.savedRegisterDetails(responseMessage: responseMessage)
            
            }
            
            
  })
    }
    
    //MARK:- Save RegisterDetails Method
    func savedRegisterDetails(responseMessage:NSMutableDictionary)
    {
        
            
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
            
            
            let email =  CommonFunctions.getUserProfile().email
            print(email)
            let userdef =  UserDefaults()
            userdef.set("LoggedIn", forKey: userLoggedInKey)
            userdef.synchronize()
            self.navigateToDashBoard()
            
        }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let row = textField.tag
//
//
//        switch row {
//        case 0:
//            strBusinessName = textField.text!
//
//        case 1:
//            if userType ==  0
//            {
//            strFirstName = textField.text!
//            strRepresentativeFirstName = ""
//            }
//            else
//            {
//                strRepresentativeFirstName  = textField.text!
//                strFirstName =  ""
//            }
//        case 2:
//            if userType ==  0
//            {
//                strLastName = textField.text!
//                strRepresentativeLastName = ""
//            }
//            else
//            {
//                strRepresentativeLastName  = textField.text!
//                strLastName =  ""
//            }
//
//        case 3:
//
//                strlocation = textField.text!
//
//        case 4:
//                strPhoneNo = textField.text!
//            case 5:
//                strEmail = textField.text!
//
//            case 6:
//                strPassword = textField.text!
//
//            case 7:
//                strConfirmPassword = textField.text!
//
//            case 8:
//                strDialCode = textField.text!
//
//
//        default:
//        print(row)
//        }
//
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        rowBeingEdited = textField.tag
//        if textField.tag == 3
//        {
//              googlePlace()
//        }
//        else
//        {
//
//        }
//    }

}
extension RegisterViewController:UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellIdentifier.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowhHeight =  0
        let identifiertext =  arrayOfCellIdentifier[indexPath.row]

        if identifiertext == "cellBusinessName"
        {
            if  selectedUserValue ==  "individual"
            {
                
                rowhHeight =  0
            }
            else
            {
                rowhHeight =  50

            }
        }
        else if identifiertext == "cellRole"
        {
            if  selectedUserValue ==  "individual"
            {
                
                rowhHeight =  0
            }
            else
            {
                rowhHeight =  50
                
            }
        }
        else
        
        {
            rowhHeight =  50
        }
        return  CGFloat(rowhHeight)
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       // tableView.separatorStyle  = .none
    
        let identifiertext =  arrayOfCellIdentifier[indexPath.row]
        let cell:customTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifiertext, for: indexPath) as! customTableViewCell
        
        if identifiertext == "cellServiceType"
        {
            
            cell.tf_UserServiceType.tag =  101
            //"Register as"
            cell.tf_UserServiceType.placeholder = "Register as"
            cell.tf_UserServiceType.text =  selectedServiceValue
            cell.tf_UserServiceType.addTarget(self, action: #selector(btnActionSelectServiceType(sender:)), for: .editingDidBegin)

        }
            
            
        else if identifiertext == "cellUserType"
        {
            
            cell.tf_SelectUserType.tag =  102
            cell.tf_SelectUserType.placeholder = "Are you a"
            cell.tf_SelectUserType.text =  selectedUserValue
    cell.tf_SelectUserType.addTarget(self, action: #selector(btnActionSelectUserType(sender:)), for: .editingDidBegin)

        }
      
        else if identifiertext == "cellBusinessName"
        {
            if selectedUserValue ==  "individual"
            {

                cell.isHidden =  true
            }
            else
            {
                cell.tfBusinessName.placeholder =  "Enter Business Name"
                cell.tfBusinessName.tag = 103
             //   CommonFunctions.setTextFieldBorder(textfield: cell.tfBusinessName)
                cell.tfBusinessName.delegate = self

            }
       
        }
        else if identifiertext == "cellRepresentativeFirstName"
        {
            var lblFName  = ""
            if  selectedUserValue ==  "individual"
            {
                userType = 0
                lblFName =  "First Name"
              
                
            }
            else
            {
                userType = 1
               
                lblFName  = "Representative Fist Name"
            }
            if registerTypeKey == "social"
            {
            cell.tf_FirstName.text = strFirstName
            }
                cell.tf_FirstName.placeholder   = lblFName
           // CommonFunctions.setTextFieldBorder(textfield: cell.tf_FirstName)
            cell.tf_FirstName.tag = 104
            cell.tf_FirstName.delegate = self


        }
        else if identifiertext == "cellLastName"
        {
            var lblLName  = ""
            if  selectedUserValue ==  "individual"
            {
                
                lblLName =  "Last Name"
               
                
            }
            else
            {
               
                lblLName = "Representative Last Name"
            }
            if registerTypeKey == "social"
            {
                cell.tfLastName.text = strLastName
            }
            cell.tfLastName.placeholder  =  lblLName
        //    CommonFunctions.setTextFieldBorder(textfield: cell.tfLastName)
            cell.tfLastName.tag = 105
            cell.tfLastName.delegate = self


        }
        else if identifiertext == "cellRole"
        {
            if selectedUserValue ==  "individual"
            {
                cell.isHidden = true
            }
            else
            {
            cell.tf_Role.text  =  selectedRoleValue

            cell.tf_Role.tag = 106

            cell.tf_Role.addTarget(self, action: #selector(btnActionSelectRole(sender:)), for: .editingDidBegin)

           cell.tf_Role.placeholder = "Role at the company"
            }
            
        }
        else if identifiertext == "cellMobile"
        {
          //  CommonFunctions.setTextFieldBorder(textfield: cell.tfMobileNo)
           // CommonFunctions.setTextFieldBorder(textfield: cell.tfCode)

            cell.tfCode.addTarget(self, action: #selector(countryCodePicker(sender:)), for: .editingDidBegin)
            cell.tfCode.tag  = 107

            cell.tfCode.delegate = self
           // cell.tfCode.tag = 4

            if countryImageName == ""
            {
                
            }
            else
            {
            cell.flagImageView.image =  UIImage(named:countryImageName)
            }
            cell.tfCode.placeholder = "Code"
            cell.tfCode.text = countryDialCode
            cell.tfMobileNo.tag = 108
            cell.tfMobileNo.placeholder = "Mobile Number"

            cell.tfMobileNo.delegate = self
            if countryDialCode == ""
            {
                
            }
            else
            {
               
            }

        }
        else if identifiertext == "cellEmail"
        {
            if registerTypeKey == "social"
            {
                cell.tfEmail.text  = strEmail
            }
            //CommonFunctions().changeTextFieldStyle(textField: cell.tfEmail)
          //  CommonFunctions.setTextFieldBorder(textfield: cell.tfEmail)
            cell.tfEmail.placeholder = "Email"
            cell.tfEmail.delegate = self
            cell.tfEmail.tag = 109

            
        }
        else if identifiertext == "cellLocation"
        {
            //  cell.tfEmail.text  = ""
            cell.tfLocation.placeholder =  "Location"
            cell.tfLocation.addTarget(self, action: #selector(OpenLocationView(sender:)), for: .editingDidBegin)

            cell.tfLocation.delegate = self
            cell.tfLocation.text = strlocation
            cell.tfLocation.tag = 110
            
            
        }
            
        else if identifiertext == "cellPassword"
            
        {
            if registerTypeKey == "social"
            {
                cell.isHidden =  true
            }
            else
            {
            //cell.tfPassword.text  = "1234567890"
            cell.tfPassword.placeholder =  "Password"
         //   CommonFunctions.setTextFieldBorder(textfield: cell.tfPassword)
            cell.tfPassword.delegate = self
            cell.tfPassword.tag = 111
            }

        }
        else if identifiertext == "cellConfirmPassword"
        {
            if registerTypeKey == "social"
            {
                cell.isHidden =  true
            }
            else
            {
            cell.tfConfirmPassword.placeholder = "Confirm Password"
            cell.tag = indexPath.row
           cell.tfConfirmPassword.delegate = self
            cell.tfConfirmPassword.tag = 112
            }

        }
        
        
        
        
     //   let update = updates[indexPath.row/2]
       // cell.nameLabel.text = update.addedByUser
    
        cell.selectionStyle =  .none
        return cell
    }
    
    
}
extension RegisterViewController : UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if selectType ==  1
        {
            let myLabel = UILabel(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60 ))
            myLabel.text =  arrayServiceType[row]
            myLabel.textAlignment =  .center
            return myLabel
        }
         if selectType == 2
         {
            let myLabel = UILabel(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60 ))
            myLabel.backgroundColor =  UIColor.clear
            myLabel.textAlignment =  .center
            myLabel.text =  arrayUserType[row]
            
            return myLabel
        }
        if selectType == 3
        {
            let myLabel = UILabel(frame: CGRect(x:0, y:0, width:pickerView.bounds.width - 30, height:60 ))
            myLabel.backgroundColor =  UIColor.clear
            myLabel.textAlignment =  .center
            
            if selectedUserValue == "business"
            {
                
                myLabel.text =  businessRoleArray[row]["description"] as? String

            }
            else
            {
                myLabel.text =  individualRole["description"] as? String

            }
            
            return myLabel
        }
        else
            
        {
            let myView = UIView(frame: CGRect(x:0,y: 0, width:pickerView.bounds.width - 30, height:60))
            myView.backgroundColor  =  UIColor.clear
            let countryImageView = UIImageView(frame: CGRect(x:10, y:20, width:25, height:20))
            var countryName = countryCodeArr[row]["name"] as! String

            var countryCode = String()
            countryCode =  countryCodeArr[row]["dial_code"] as! String
            var imageName =  String ()
            imageName  =  countryImageArr[row]
            
            countryImageView.image = UIImage(named:imageName)
            
           
            let countryCodeLabel = UILabel(frame: CGRect(x:40, y:0, width:100  , height:60 ))
            countryCodeLabel.text = countryCode
            countryCodeLabel.textAlignment =  .center
            countryCodeLabel.backgroundColor  = UIColor.clear
            myView.addSubview(countryCodeLabel)

            let countryNamesLabel = UILabel(frame: CGRect(x:countryCodeLabel.frame.size.width+20, y:0, width:200  , height:60 ))
            countryNamesLabel.text = countryName
            countryNamesLabel.textAlignment =  .center
            countryNamesLabel.backgroundColor  = UIColor.clear

            myView.addSubview(countryNamesLabel)
            myView.addSubview(countryImageView)
            return myView
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectType == 1
        {
            return arrayServiceType.count
        }
        else if selectType ==  2
        {
            return arrayUserType.count
        }
        else if selectType ==  3
        {
            if selectedUserValue == "business"
            {
                
              return businessRoleArray.count
                
            }
            else
            {

                return 1
            }
            
        }
        else
        {
            return countryCodeArr.count
        }
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectType == 1
        {
            
        }
        else if selectType ==  2
        {
            
        }
        else if selectType ==  3
        {
            
        }
        else
        {
            countryDialCode =  countryCodeArr[row]["dial_code"] as! String
            countryImageName  =  countryImageArr[row]
            regTableView.reloadData()
        }
    }

}
extension RegisterViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
            print("Place name: \(place.name)")
            print("Place address: \(String(describing: place.formattedAddress))")
            print("Place attributions: \(String(describing: place.attributions))")
            dismiss(animated: true, completion: nil)
            strlocation =  place.formattedAddress!
            convertAddressIntoLatLong(address: strlocation)
            regTableView.reloadData()
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
