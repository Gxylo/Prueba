//
//  Overlay.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/22/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import Foundation
import UIKit

open class Overlay{
    
    class var shared: Overlay {
        struct Static {
            static let instance: Overlay = Overlay()
        }
        return Static.instance
    }
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var labeTitle = UILabel()
    
    
    open func showOverlay(_ view: UIView){
        //creating overlay
        overlayView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.clipsToBounds = true
        
        //creating activityIndicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        
        //adding subviews
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        overlayView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    open func showOverlayBasic(_ view: UIView, title: String){
        //creating overlay
        overlayView.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2.5, height: view.bounds.height/4.8)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 14.0
        overlayView.clipsToBounds = true
        
        //creating activityIndicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        //Creating label for tittle
        labeTitle.frame = CGRect(x: 0, y: 0, width: 96, height: 20)
        labeTitle.text = title
        labeTitle.font = UIFont(name: "Gotham-Book", size: 15)
        labeTitle.textColor = UIColor.white
        labeTitle.textAlignment = NSTextAlignment.center
        labeTitle.sizeToFit()
        labeTitle.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2 + 32)
        
        
        //adding subviews
        overlayView.addSubview(activityIndicator)
        overlayView.addSubview(labeTitle)
        view.addSubview(overlayView)
        
        overlayView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    open func showOverlayWithCustomColor(_ view: UIView, color: UIColor){
        //creating overlay
        overlayView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        overlayView.center = view.center
        overlayView.backgroundColor = color
        overlayView.clipsToBounds = true
        
        //creating activityIndicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        
        //adding subviews
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        overlayView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    open func hideOverlay(){
        //remove views
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}

