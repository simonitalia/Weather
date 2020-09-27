//
//  VenuesTableViewCell.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class VenuesTableViewCell: UITableViewCell {
	
	//MARK: - Properties
	
	enum Location: Int {
		case name = 0
		case condition
		case temperature
	}
	
	//MARK: - Accessible Cell identifiers
	
	static let reuseIdentifier = "VenuesTableViewCell"
	static let nibName = "VenuesTableViewCell"
	
	//MARK: - Cell Outlets
	
	@IBOutlet var labels: [UILabel]!
	@IBOutlet weak var iconImageView: UIImageView!
	
	
	//MARK: - Cell Configuration
	
	func setContent(for location: Venue) {
		
		labels.forEach {
			switch $0.tag {
				case Location.name.rawValue:
					$0.text = location.name
				
				case Location.condition.rawValue:
					$0.text = location.condition ?? "?"
			
				case Location.temperature.rawValue:
					$0.text = location.temperature ?? "?"
				
				default:
					break
			}
		}
	}
}
