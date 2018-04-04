

import Foundation
import UIKit
let enableLogs = 1

// MARK: - Status Code
let successStatusCode = 200
let noRecordsStatusCode = 300
let errorStatusCode = 400
let error1StatusCode = 401

// MARK: - HTTP Methods
let postHTTPMethod = "POST"
let getHTTPMethod = "GET"

// MARK: - HTTP Header Fields
let httpHeaderFields = ["Content-Type": "application/json"]


let appDelegate = UIApplication.shared.delegate as! AppDelegate
var base_URL : String = "https://www.stampmemoriesdev.com/api/"
var login_URL :String =  "login"
var registerUrl :String = "register"
var getCustomerRolesURL : String = "customerroles"
var getProviderRolesURL :String =  "providerroles"
