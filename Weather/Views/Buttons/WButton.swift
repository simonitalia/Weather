//
//  WButton.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import UIKit

class WButton: UIButton {
	
	private enum Text: String {
		case all = "Filter: All"
		case filtered = "Filter: "
	}
	
	
	func setButtonText(with text: String?) {
		
		if let text = text {
			setTitle(Text.filtered.rawValue + text, for: .normal)
			
		} else {
			setTitle(Text.all.rawValue, for: .normal)
		}
	}
}
