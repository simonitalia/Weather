//
//  UIViewController+Extensions.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import UIKit

extension UIViewController {
	
	func presentAlert(title: String, message: String, completionHandler: Selector?) {
		
		enum TitleText {
			enum ActionButton: String {
				case cancel = "Cancel"
				case tryAgain = "Try Again"
			}
		}
		
		DispatchQueue.main.async {
			let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: TitleText.ActionButton.cancel.rawValue, style: .default))
		
			//include completion action in alert
			if let handler = completionHandler {
				ac.addAction(UIAlertAction(title: TitleText.ActionButton.tryAgain.rawValue, style: .default, handler: {
					_ in self.perform(handler)
				}))
			}
			
			self.present(ac, animated: true)
		}
	}
}
