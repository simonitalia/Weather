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
	
	
	//MARK: - Accessible Cell identifiers
	
	static let reuseIdentifier = "VenuesTableViewCell"
	static let nibName = "VenuesTableViewCell"
	
	
	//MARK: - Cell NIB Connections
	
	@IBOutlet var labels: [UILabel]!
	@IBOutlet weak var iconImageView: UIImageView!
	
	
	//MARK: - Cell Configuration
	
	override func awakeFromNib() {
		configureCell()
	}
	
	
	private func configureCell() {
		self.selectionStyle = .none
	}
	
	
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
			
			if let conditionIcon = venue.conditionIcon {
				iconImageView?.image = getImage(for: conditionIcon)
			}
		}
	}
	
	
	private func getImage(for conditionIcon: String) -> UIImage? {
		let image = Constants.AssetType.getImage(for: .conditionIcon(named: conditionIcon))
		return image
	}
}
