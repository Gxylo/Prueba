//
//  HomeVC.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/22/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AWSCognitoIdentityProvider

class HomeVC: UIViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
    }

    func refresh() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
            })
            
            return nil
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
