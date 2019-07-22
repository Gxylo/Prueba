//
//  SignInVC.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/22/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    //Keyboard Utils
    var keyboardHeight:CGFloat!
    var isKeyboardPresent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.username.delegate = self
        self.password.delegate = self
        closeKeyboardWhenTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.password.text = nil
        self.username.text = usernameText
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.isKeyboardPresent == false {
                
                keyboardHeight = keyboardSize.height
                
                if self.btnLogin.transform.isIdentity {
                    
                    self.btnLogin?.transform = CGAffineTransform.init(translationX: 0, y: -(keyboardSize.height))
                }
                
                self.isKeyboardPresent = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            if isKeyboardPresent == true{
                
                self.btnLogin!.transform = .identity
                self.isKeyboardPresent = false
            }
        }
    }
    
    
    @IBAction func signInPressed(_ sender: AnyObject) {
        
        self.loginUser()
    }
    
    func loginUser()  {
        
        let username: String = self.username.text!
        let password: String = self.password.text!
        
        if username == "" && password == "" {
            let alertController = UIAlertController(title: "Acompleta la información",
                                                    message: "Por favor ingresa los campos usuario y contraseña.",
                                                    preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Intente de nuevo", style: .default, handler: nil)
            alertController.addAction(retryAction)
        } else if username == "" {
            
            Utils.shared.applyDamping(view: self.username)
            return
        } else if (username.count < 2) {
            
            Utils.shared.applyDamping(view: self.username)
            return
        } else if password == "" {
            
            Utils.shared.applyDamping(view: self.password)
            return
        } else if (password.count < 2) {
            
            Utils.shared.applyDamping(view: self.password)
            return
        } else {
            
            Overlay.shared.showOverlayBasic(self.view, title: "Iniciando...")
            let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: username, password: password)
            self.passwordAuthenticationCompletion?.set(result: authDetails)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.username == textField {
            
            self.password.becomeFirstResponder()
        } else {
            
            self.loginUser()
        }
        
        return  true
    }
}

extension SignInVC: AWSCognitoIdentityPasswordAuthentication {
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        DispatchQueue.main.async {
            if (self.usernameText == nil) {
                self.usernameText = authenticationInput.lastKnownUsername
            }
        }
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                //print(error.localizedFailureReason.)
                //print(error.code)
                //print(error.domain)
                //print(error.localizedDescription)
                
                Overlay.shared.hideOverlay()
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Intentar de nuevo", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.username.text = nil
                Overlay.shared.hideOverlay()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension UIViewController {
    func closeKeyboardWhenTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closeKeyboard() {
        
        self.view.endEditing(true)
    }
}
