//
//  WButton.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import UIKit

class WButton: UIButton {

	override func awakeFromNib() {
		configureButton()
	}
	
	func configureButton() {
		setTitleColor(.white, for: .normal)
		backgroundColor = .systemPurple
	}
}
