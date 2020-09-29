//
//  WTitleOneLabel.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import UIKit

class WLabelTitleTwo: WLabel {

	override func awakeFromNib() {
		configureLabel()
	}
	
	override func configureLabel() {
		super.configureLabel()
		font = UIFont.preferredFont(forTextStyle: .title2)
		textColor = .darkGray
		
	}

}
