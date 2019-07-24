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

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbTitleView: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?

    var orderArray: NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.lbTitleView.isHidden = true
        
        self.filterView.isHidden = true
        
    }

    func refresh() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
                
                self.showAlert(name: self.response?.username ?? "Amigo")
                self.orderArray = NSMutableArray()
                self.getOrders()
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
    
    func getOrders()  {
        
        var urlString = URLConstants.shared.getOrders()
        
        urlString = urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
        
        self.view.isUserInteractionEnabled = false
        
        Overlay.shared.showOverlayBasic(self.view, title: "Cargando...")
        
        Alamofire.request(urlString, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                Overlay.shared.hideOverlay()
                
                self.view.isUserInteractionEnabled = true
                
                self.lbTitleView.isHidden = false
                
                self.filterView.isHidden = false
                
                switch response.result {
                case .success:
                    
                    let result = JSON(response.data!)
                    
                    print("Orders : \(result)")
                    
                    if (result.array != nil) {
                        
                        if result.array?.count == 0 {
                            
                            self.noShowOrders()
                            return
                        }
                        
                        var id: String?
                        
                        var internalGuide: Int?
                        
                        var guide: Int?
                        
                        var messengerId: Int?
                        
                        var status: String?
                        
                        var createdAt: String?
                        
                        var statusOrder: String?
                        
                        for item in result.arrayValue {
                            
                            if let value = item["id"].string{
                                
                                id = value
                            }else{
                                
                                id = "0"
                            }
                            
                            if let value = item["internalGuide"].int{
                                
                                internalGuide = value
                            }else{
                                
                                internalGuide = 0
                            }
                            
                            if let value = item["guide"].int{
                                
                                guide = value
                            }else{
                                
                                guide = 0
                            }
                            
                            if let value = item["messengerId"].int{
                                
                                messengerId = value
                            }else{
                                
                                messengerId = 0
                            }
                            
                            if let value = item["status"].string{
                                
                                status = value
                            }else{
                                
                                status = "3 * 2"
                            }
                            
                            if let value = item["createdAt"].string{
                                
                                createdAt = value
                            }else{
                                
                                createdAt = Date().description
                            }
                            
                            if let value = item["statusOrder"].string{
                                
                                statusOrder = value
                            }else{
                                
                                statusOrder = "Finalizado"
                            }
                            
                            let order = Order(id: id!, internalGuide: internalGuide!, guide: guide!, messengerId: messengerId!, status: status!, createdAt: createdAt!, statusOrder: statusOrder!)
                            
                            self.orderArray?.add(order)
                            
                            self.tableView.reloadData()
                        }
                    } else {
                        
                        self.noShowOrders()
                    }
                    

                    break
                case .failure(let error):
                    
                    Overlay.shared.hideOverlay()
                    
                    print(error)
                    
                    self.noShowOrders()
                }
        }

    }
    
    func noShowOrders()  {
        
        let alert = UIAlertController(title: "¡Atención!", message: "No se pudo descargar el listado, intentelo más tarde", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action) in
            
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true) {
            
        }

    }
    
    //Mark TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.orderArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = self.orderArray?[indexPath.row] as? Order
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let lbGuide = cell.viewWithTag(1) as! UILabel
        
        let lbinternalGuide = cell.viewWithTag(2) as! UILabel
        
        let lbId = cell.viewWithTag(3) as! UILabel
        
        let imgStatus = cell.viewWithTag(4) as! UIImageView
        
        let lbDateCreated = cell.viewWithTag(5) as! UILabel
        
        lbGuide.text = "Guía: \((order?.guide)!)"
        
        lbinternalGuide.text = "Guía internacional: \((order?.internalGuide)!)"
        
        lbId.text = "id: \((order?.id)!)"
        
        lbDateCreated.text = "\((order?.createdAt)!)"

        switch order?.statusOrder {
            
        case "Finalizado":
            
            imgStatus.image = UIImage(named: "success")
            
            break
            
        default:
            
            imgStatus.image = UIImage(named: "canceled")
            
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let order = self.orderArray?[indexPath.row] as? Order
        let detailOrderView = self.storyboard?.instantiateViewController(withIdentifier: "orderDatailView") as? DetailOrderVC
        detailOrderView?.order = order
        self.navigationController?.pushViewController(detailOrderView!, animated: true)
        
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
