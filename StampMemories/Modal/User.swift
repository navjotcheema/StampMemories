//
//  user.swift
//  StampMemories
//
//  Created by Apple on 02/02/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class User: NSObject,NSCoding {
    var account_id = ""
    var api_token = ""
    var bio = ""
    var business_name = ""
    var country_code = ""
    var credit_card_token = ""
    var customer_id = ""
    var devicetoken = ""
    var devicetype = ""
    var email = ""
    var firstname = ""
    var id = ""
    var is_provider = ""
    var lastname = ""
    var latitude = ""
    var locale = ""
    var location = ""
    var longitude = ""
    var mobile_verified = ""
    var phone = ""
    var profile_image = ""
    var profile_url = ""
    var provider = ""
    var provider_id = ""
    var representative_first_name  = ""
    var representative_last_name = ""
    var slug = ""
   var social_id = ""
    var social_type  = ""
    var status = ""
    var user_type = ""

    override init() {
        
    }
    required init?(coder aDecoder: NSCoder) {
  
        self.account_id = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "account_id")
        
        self.api_token = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "api_token")
        
        self.bio = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "bio")
        self.business_name = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "business_name")
        self.country_code = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "country_code")
        self.credit_card_token = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "credit_card_token")
        self.customer_id =  CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "customer_id")
        self.devicetoken = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "devicetoken")
        self.devicetype = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "devicetype")
        self.email = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "email")
        
        self.firstname = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "firstname")
        
        self.id = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "id")
         self.is_provider = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "is_provider")
         self.lastname = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "lastname")
         self.latitude = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "latitude")
         self.locale = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "locale")
         self.location = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "location")
         self.longitude = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "longitude")
         self.mobile_verified = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "mobile_verified")
         self.phone = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "phone")
         self.profile_image = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "profile_image")
         self.profile_url = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "profile_url")
         self.provider = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "provider")
         self.provider_id = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "provider_id")
         self.representative_first_name  = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "representative_first_name")
         self.representative_last_name = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "representative_last_name")
         self.slug = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "slug")
         self.social_id = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "social_id")
         self.social_type  = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "social_type")
         self.status = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "status")
         self.user_type = CommonFunctions().optionalDecodedString(aDecoder: aDecoder, forKey: "user_type")
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode( self.account_id, forKey: "account_id")
        aCoder.encode( self.api_token, forKey: "api_token")
        aCoder.encode( self.bio, forKey: "bio")
        aCoder.encode( self.business_name, forKey: "business_name")
        aCoder.encode( self.country_code, forKey: "country_code")
        aCoder.encode( self.credit_card_token, forKey: "credit_card_token")
        aCoder.encode( self.customer_id, forKey: "customer_id")
        aCoder.encode( self.devicetoken, forKey: "devicetoken")
        aCoder.encode( self.devicetype, forKey: "devicetype")
        aCoder.encode( self.email, forKey: "email")
        aCoder.encode( self.firstname, forKey: "firstname")
        aCoder.encode( self.id, forKey: "id")
        aCoder.encode( self.is_provider, forKey: "is_provider")
        aCoder.encode( self.lastname, forKey: "lastname")
        aCoder.encode( self.latitude, forKey: "latitude")
        aCoder.encode( self.locale, forKey: "locale")
        aCoder.encode( self.location, forKey: "location")
        aCoder.encode( self.longitude, forKey: "longitude")
        aCoder.encode( self.mobile_verified, forKey: "mobile_verified")
        aCoder.encode( self.phone, forKey: "phone")
        aCoder.encode( self.profile_image, forKey: "profile_image")
        aCoder.encode( self.provider, forKey: "provider")
        aCoder.encode( self.provider_id, forKey: "provider_id")
        aCoder.encode( self.representative_first_name, forKey: "representative_first_name")
        aCoder.encode( self.representative_last_name, forKey: "representative_last_name")
        aCoder.encode( self.slug, forKey: "slug")
        aCoder.encode( self.social_id, forKey: "social_id")
        aCoder.encode( self.social_type, forKey: "social_type")
        aCoder.encode( self.status, forKey: "status")
        aCoder.encode( self.user_type, forKey: "user_type")

        
        
        
        
    }
    
    
}


