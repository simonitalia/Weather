//
//  WLabelTitleThreeLabel.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import UIKit

class WLabelTitleThree: WLabel {

	override func awakeFromNib() {
		configureLabel()
	}
	
	override func configureLabel() {
		super.configureLabel()
		font = UIFont.preferredFont(forTextStyle: .title3)
		textColor = .darkGray
		numberOfLines = 0
	}
}
