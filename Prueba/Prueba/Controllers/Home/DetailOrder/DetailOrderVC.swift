//
//  DetailOrderVC.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/23/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import UIKit

class DetailOrderVC: UIViewController {
    
    @IBOutlet weak var lbAmount: UILabel!
    
    @IBOutlet weak var lbDescriptionOrder: UILabel!
    
    var order: Order?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    func setupView()  {
        
        if self.order != nil {
            
            self.lbDescriptionOrder.text = "id: \((self.order?.id)!) guía: \((self.order?.guide)!) \nguía internacional: \((self.order?.internalGuide)!) messengerID: \((self.order?.messengerId)!) \nEstatus: \((self.order?.statusOrder)!)\nCreado el día: \((self.order?.createdAt)!)"
        }
    }

    @IBAction func scannView(_ sender: Any) {
        
        
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
