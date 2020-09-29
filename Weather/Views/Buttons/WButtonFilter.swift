//
//  WButton.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import UIKit

class WButtonFilter: WButton {
	
	private enum Text: String {
		case all = "Filter: All"
		case filtered = "Filter: "
	}
	

	override func awakeFromNib() {
		configureButton()
	}
	
	
	override func configureButton() {
		super.configureButton()
		setDefaultButtonText()
	}
	
	
	private func setDefaultButtonText() {
		setTitle(Text.all.rawValue, for: .normal)
	}
	
	
	func setButtonText(with text: String?) {
		
		if let text = text {
			setTitle(Text.filtered.rawValue + text, for: .normal)
			
		} else {
			setDefaultButtonText()
		}
	}
}
