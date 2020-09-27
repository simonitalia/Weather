//
//  CountriesTableViewCell.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
	
	//MARK: - Accessible Cell identifiers
	
	static let reuseIdentifier = "CountriesTableViewCell"
	static let nibName = "CountriesTableViewCell"

	
	//MARK: - Cell Configuration
	
	func setTableCellContent(for country: Country) {
		self.textLabel?.text = country.name
		
//		self.imageView?.image = getTableCellImage(for: country.name)
	}
	
	
	private func getTableCellImage(for countryName: String) -> UIImage? {
		return UIImage()
	}
	
}
