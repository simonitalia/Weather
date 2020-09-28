//
//  VenuesTableViewCell.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class VenuesTableViewCell: UITableViewCell {
	
	//MARK: - Properties
	
	enum VenueLocation: Int {
		case name = 0
		case condition
		case temperature
	}
	
	private enum Conditions {
		
	}
	
	
	//MARK: - Accessible Cell identifiers
	
	static let reuseIdentifier = "VenuesTableViewCell"
	static let nibName = "VenuesTableViewCell"
	
	
	//MARK: - Cell NIB Connections
	
	@IBOutlet var labels: [UILabel]!
	@IBOutlet weak var iconImageView: UIImageView!
	
	
	//MARK: - Cell Configuration
	
	func setContent(for venue: Venue) {
		labels.forEach {
			switch $0.tag {
				case VenueLocation.name.rawValue:
					$0.text = venue.name
					
				case VenueLocation.condition.rawValue:
					$0.text = venue.condition ?? "-"
					
				case VenueLocation.temperature.rawValue:
					$0.text = venue.temperature ?? "-"
				
				default:
					break
			}
			
			iconImageView?.image = getImage(for: venue.conditionIcon)
		}
	}
	
	
	private func getImage(for conditionIcon: String?) -> UIImage? {
		
		switch conditionIcon {
			case "clear":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.clear)
			
			case "fog":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.fog)
				
			case "hazy":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.hazy)
				
			case "mostlycloudy":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.mostlyCloudy)
				
			case "partlycloudy":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.partlyCloudy)
			
			case "rain":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.rain)
				
			case "tstorms":
				return UIImage(named: Constants.ImageAsset.ConditionIcon.thunderStorms)
			
			default:
				return nil
		}
	}
}
