//
//  URLCostants.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/22/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

let CognitoIdentityUserPoolRegion: AWSRegionType = .USWest2
let CognitoIdentityUserPoolId = "us-west-2_4XnjJCpHW"
let CognitoIdentityUserPoolAppClientId = "6ud4dtemrkmgd2dntdjmc4n6pl"
let CognitoIdentityUserPoolAppClientSecret = ""

let AWSCognitoUserPoolsSignInProviderKey = "UserPool"


open class URLConstants{

    
    let api = ""
    
    class var shared: URLConstants {
        struct Static {
            static let instance: URLConstants = URLConstants()
        }
        return Static.instance
    }
    
    @objc dynamic func getTransactions() -> String{
        
        return ""
    }

}
