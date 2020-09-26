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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
		
    }
	
	
	func setTableCellContent(for country: Country) {
		let text = country.name.capitalizingFirstLetter()
		self.textLabel?.text = text
		
		self.imageView?.image = getTableCellImage(for: country.name)
	}
	
	
	private func getTableCellImage(for countryName: String) -> UIImage? {
		return UIImage()
	}
	
}
