//
//  WSortByButton.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import UIKit

class WSortByButton: UIButton {
	
	enum SortType: String {
		case venueName = "A-Z"
		case temperature = "Temperature"
		case lastUpdated  = "Last Updated"
	}
	
	
	func setButtonText(for button: WSortByButton) {
		switch button.tag {
			case 0:
				button.setTitle(SortType.venueName.rawValue, for: .normal)
				
			case 1:
				button.setTitle(SortType.temperature.rawValue, for: .normal)
				
			case 2:
				button.setTitle(SortType.lastUpdated.rawValue, for: .normal)
				
			default:
				break
		}
	}
}
