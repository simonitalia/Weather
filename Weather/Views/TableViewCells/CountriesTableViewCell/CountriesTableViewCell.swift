//
//  CountriesTableViewCell.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
	
	
	//MARK: - Cell NIB Connections
	
	@IBOutlet weak var cellLabel: UILabel!
	@IBOutlet weak var cellImageView: UIImageView!
	
	
	//MARK: - Accessible Cell identifiers
	
	static let reuseIdentifier = "CountriesTableViewCell"
	static let nibName = reuseIdentifier
	

	//MARK: - Cell Configuration
	
	override func awakeFromNib() {
		configureCell()
	}
	
	
	private func configureCell() {
//		let padding = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
//		bounds = bounds.inset(by: padding)
		self.selectionStyle = .none
	}
	
	
	func setContent(with country: Country) {
		cellLabel?.text = country.name
		let image = Constants.AssetType.getImage(for: .flag(id: country.countryID))
		cellImageView?.image = image
	}
}
