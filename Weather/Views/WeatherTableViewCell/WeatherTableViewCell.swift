//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
	
	enum Location: Int {
		case name = 0
		case condition
		case temperature
	}
	
	//MARK: - Accessible Cell identifiers
	
	static let reuseIdentifier = "WeatherTableViewCell"
	static let nibName = "WeatherTableViewCell"
	
	//MARK: - Cell Outlets
	
	@IBOutlet var labels: [UILabel]!
	@IBOutlet weak var iconImageView: UIImageView!
	
	
	func setTableCellContent(for location: Weather) {
		
		labels.forEach {
			switch $0.tag {
				case Location.name.rawValue:
					$0.text = location.name
				
				case Location.condition.rawValue:
					$0.text = location.condition ?? "?"
			
				case Location.temperature.rawValue:
					$0.text = location.temperature ?? "?"
				
				default:
					fatalError("Tag should Should not be none")
			}
		}
	}
}
