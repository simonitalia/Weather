//
//  WLabelTitleThree.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import UIKit

class WLabelSubheadline: WLabel {

	override func awakeFromNib() {
		configureLabel()
	}
	
	override func configureLabel() {
		super.configureLabel()
		font = UIFont.preferredFont(forTextStyle: .subheadline)
		numberOfLines = 0
		textColor = .systemPurple
	}
}
