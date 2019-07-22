//
//  Utils.swift
//  Prueba
//
//  Created by Gerardo Xiloxochitl on 7/22/19.
//  Copyright © 2019 Gerardo Xiloxochitl. All rights reserved.
//

import UIKit

class Utils: NSObject {

	// MARK : Device Size

	class var shared: Utils {
		struct Static {
			static let instance: Utils = Utils()
		}
		return Static.instance
	}

	struct ScreenSize
	{
		static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
		static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
		static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
		static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
	}

	struct DeviceType
	{
		static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
		static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
		static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
		static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
		static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
		static let IS_IPHONE_7          = IS_IPHONE_6
		static let IS_IPHONE_7P         = IS_IPHONE_6P
		static let IS_IPHONE_X			= UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
		static let IS_IPHONE_X_OR_HIGHER = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH > 812.0
		static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
		static let IS_IPAD_PRO_9_7      = IS_IPAD
		static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
	}

	@objc dynamic func isIpad() -> Bool {

		return DeviceType.IS_IPAD
	}

	@objc dynamic func isIphoneX() -> Bool {

		return DeviceType.IS_IPHONE_X
	}

	@objc dynamic func isIphoneX_Higher() -> Bool {

		return DeviceType.IS_IPHONE_X_OR_HIGHER
	}


	@objc dynamic func isIphone4S_Less() -> Bool {

		return DeviceType.IS_IPHONE_4_OR_LESS
	}

	@objc dynamic func isIphone5() -> Bool {

		return DeviceType.IS_IPHONE_5
	}

	@objc dynamic func isIphone7() -> Bool {

		return DeviceType.IS_IPHONE_7
	}

	@objc dynamic func isIphonePlus() -> Bool {

		return DeviceType.IS_IPHONE_6P
	}


	//Shadow views
	@objc dynamic func applyShadowNavBar(view: UIView) {

		let size = view.bounds.size
		let width = size.width
		let height = size.height
		let rect = CGRect(x: 0, y: height, width: width , height: 1)
		let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)

		let layer = view.layer
		layer.shadowPath = path.cgPath
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.6
		layer.shadowRadius = 5
		layer.shadowOffset = CGSize(width: 0, height: 0)

		//border
		let borderView = UIView(frame: CGRect(x: 0, y: height - 0.2, width: width , height:2))
		borderView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
		view.addSubview(borderView)

	}

	//MARK : Colors App
	//Colors
	@objc dynamic func color_greenApp() -> UIColor {

		return UIColor.init(red: 65.0/255.0, green: 117.0/255, blue: 5.0/255, alpha: 1.0)
	}

	@objc dynamic func color_greenLightApp() -> UIColor {

		return UIColor.init(red: 46.0/255.0, green: 175.0/255, blue: 154.0/255, alpha: 1.0)
	}


	@objc dynamic func color_blueApp() -> UIColor {

		return UIColor.init(red: 23.0/255.0, green: 137.0/255, blue: 251.0/255, alpha: 1.0)
	}

	@objc dynamic func color_orangeApp() -> UIColor {

		return UIColor.init(red: 255.0/255.0, green: 147.0/255, blue: 0.0/255, alpha: 1.0)
	}

	@objc dynamic func color_grayColorApp() -> UIColor {

		return UIColor.init(red: 175.0/255.0, green: 175.0/255, blue: 175.0/255, alpha: 1.0)
	}


	@objc dynamic func color_redApp() -> UIColor {

		return UIColor.init(red: 255.0/255.0, green: 38.0/255, blue: 0.0/255, alpha: 1.0)
	}

	//Mark : Move views

	@objc dynamic func addWidthView(widthAdd: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width + widthAdd, height: view.frame.size.height)
	}

	@objc dynamic func addHeightView(heightAdd: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height + heightAdd)
	}

	@objc dynamic func upView(yPosition: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - yPosition, width: view.frame.size.width, height: view.frame.size.height)
	}

	@objc dynamic func downView(yPosition: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y + yPosition, width: view.frame.size.width, height: view.frame.size.height)
	}

	@objc dynamic func moveLeftView(xPosition: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x - xPosition, y: view.frame.origin.y , width: view.frame.size.width, height: view.frame.size.height)
	}

	@objc dynamic func moveRightView(xPosition: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x + xPosition, y: view.frame.origin.y , width: view.frame.size.width, height: view.frame.size.height)
	}

	@objc dynamic func reduceViewHeight(heightQuit: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height - heightQuit)
	}

	@objc dynamic func reduceViewWidth(widthQuit: CGFloat, view: UIView){

		view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.size.width - widthQuit, height: view.frame.size.height)
	}

	@objc dynamic func addHeightLayout(height: CGFloat, layout: NSLayoutConstraint){

		layout.constant = layout.constant + height
	}

	@objc dynamic func quitHeightLayout(height: CGFloat, layout: NSLayoutConstraint){

		layout.constant = layout.constant - height
	}

	@objc dynamic func applyDamping(view: UIView) {

		view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 0.5, options: [], animations:
			{
				view.transform = CGAffineTransform(scaleX: 1, y: 1)
		}, completion: nil)

	}
}
