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
	
	func setContent(with country: Country) {
		textLabel?.text = country.name
		imageView?.image = Countries.getFlagImage(for: country.countryID)
	}
}
