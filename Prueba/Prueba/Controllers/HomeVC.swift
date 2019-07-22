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
                
                self.showAlert(name: self.response?.username ?? "Amigo")
                
            })
            
            return nil
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }

    func showAlert(name: String)  {
        
        let alert = UIAlertController(title: "¡Hola \(name)!", message: "Bienvenido a la aplicación de prueba...", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action) in
            
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true) {
            
        }
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
