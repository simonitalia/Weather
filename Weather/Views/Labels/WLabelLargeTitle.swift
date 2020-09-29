//
//  WTemperatureLabel.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import UIKit

class WLabelLargeTitle: WLabel {

	override func awakeFromNib() {
		configureLabel()
	}
	
	override func configureLabel() {
		super.configureLabel()
		font = UIFont.preferredFont(forTextStyle: .largeTitle)
		textColor = .systemPurple
		textAlignment = .right
	}
}
