//
//  WActivityIndicator.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import UIKit

class WActivityIndicatorView: UIActivityIndicatorView {
	
	override func awakeFromNib() {
		configureSpinner()
	}

	
	private func configureSpinner() {
		self.color = .gray
		self.style = .large
		self.isHidden = true
	}
	
	
	func animateSpinner(_ bool: Bool) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			bool ? self.startAnimating() : self.stopAnimating()
			bool ? (self.isHidden = false) : (self.isHidden = true)
		}
	}
}
