//
//  Constants.swift
//  Ugurcan
//  Created by Arshdeep Kaur on 07/09/17.
//  Copyright © 2017 Apple. All rights reserved.

import Foundation
import UIKit

// Social API Keys and Ids
let facebookAppId = "1788724318084376"
let googleAPIKey = "1:735448778712:ios:a10ff4f581488100"
let googleOauthClientId = "735448778712-cm8ce5v1c724sppg57o6js718641pg0t.apps.googleusercontent.com"
// MARK: - Common Constants

// MARK: - Alert Button Titles
enum SocialProfileType: Int
{
    
    case Facebook   = 1
    case Google  = 2
    
}

//MARK:-

// MARK: - User Default Keys

let userProfileKey = "UserProfile"
let rememberUserKey = "RememberUser"
let rememberedUsernameKey = "RememberedUsername"
let rememberedPasswordKey  = "RemmberPassword"
let userLoggedInKey = "UserLoggedIn"

let alertBtnTitleOK = "OK"
let alertBtnTitleCancel = "Cancel"
let alertBtnTitleSubmit = "Submit"
let alertBtnTitleYes = "Yes"
let alertBtnTitleNo = "No"
let emailKey = "email"
let idKey = "id"
let firstNameKey  = "first_name"
let lastNameKey = "last_name"
let alertNoInternetConnection = "No Internet connection"

let navBarColor = "#43cbcb"
let alertFailedToFetchFacebookProfile = "Failed to fetch Facebook profile"
let alertFailedToFetchGoogleProfile = "Failed to fetch Google profile"
let alertFailedToFetchInstagramProfile = "Failed to fetch Instagram profile"
