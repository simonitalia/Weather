//
//  WLabel.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import UIKit

class WLabel: UILabel {
	
	override func awakeFromNib() {
		configureLabel()
	}

	//MARK: - Label Configuration
	
	func configureLabel() {
		adjustsFontSizeToFitWidth = true
		font = UIFont.preferredFont(forTextStyle: .body)
		textColor = .lightGray
		textAlignment = .left
	}
}
