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
	static let nibName = reuseIdentifier
	
	
	//MARK: - Cell NIB Connections
	
	@IBOutlet var cellLabels: [UILabel]!
	@IBOutlet weak var cellImageView: UIImageView!
	
	
	//MARK: - Cell Configuration
	
	override func awakeFromNib() {
		configureCell()
	}
	
	
	private func configureCell() {
		self.selectionStyle = .none
	}
	
	
	func setContent(for venue: Venue) {
		cellLabels.forEach {
			switch $0.tag {
				case VenueLocation.name.rawValue:
					$0.text = venue.name
				
				case VenueLocation.condition.rawValue:
					$0.text = venue.condition ?? Constants.Text.setDefaultText(prefix: nil)
					
				case VenueLocation.temperature.rawValue:
					$0.text = venue.temperature ?? Constants.Text.setDefaultText(prefix: nil)
				
				default:
					break
			}
			
			if let conditionIcon = venue.conditionIcon {
				cellImageView?.image = getImage(for: conditionIcon)
			} else {
				cellImageView.image = UIImage(named: Constants.AssetType.defaultImage)
			}
		}
	}
	
	
	private func getImage(for conditionIcon: String) -> UIImage? {
		let image = Constants.AssetType.getImage(for: .conditionIcon(named: conditionIcon))
		return image
	}
}
