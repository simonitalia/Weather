//
//  VenueDetailsViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import UIKit


class VenueDetailsViewController: UIViewController {
	
	private enum LabelsText: Int {
		case name = 0
		case temperature
		case condition
		case feelsLikeTitle
		case humidityTitle
		case windTitle
		case feelsLike
		case humidity
		case wind
		case lastUpdated
		
		enum TitleText {
			static let feelsLike = "Feels Like"
			static let humidity = "Humidity"
			static let wind = "Wind"
		}
	}
	
	//MARK: - Storyboard Outlets
	
	@IBOutlet weak var conditionImageView: UIImageView!
	@IBOutlet var detailsLabels: [UILabel]!
	
	
	var venue: Venue?

    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigationBar()
		configureImageView()
		configureLabels()
    }
    
	
	//MARK: - UI Configuration

	private func configureNavigationBar() {
		title = venue?.name ?? "Weather"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
	}
	
	
	private func configureImageView() {
		guard let icon = venue?.conditionIcon else {
			conditionImageView.image = UIImage(named: Constants.AssetType.defaultImage)
			return
		}
		
		let image = Constants.AssetType.getImage(for: .conditionIcon(named: icon))
		conditionImageView.image = image
	}
	
	
	private func configureLabels() {
		guard let venue = venue else { return }
		
		for label in detailsLabels {
			let tag = LabelsText.init(rawValue: label.tag)
			
			switch tag {
				case .name:
					label.text = venue.name
				case .temperature:
					label.text = venue.temperature
				case .condition:
					label.text = venue.condition
				case .feelsLikeTitle:
					label.text = LabelsText.TitleText.feelsLike
				case .humidityTitle:
					label.text = LabelsText.TitleText.humidity
				case .windTitle:
					label.text = LabelsText.TitleText.wind
				case .feelsLike:
					label.text = venue.feelsLike
				case .humidity:
					label.text = venue.humidity?.dropPrefix("Humidity: ")
				case .wind:
					label.text = venue.wind?.dropPrefix("Wind: ")
				case .lastUpdated:
					if let lastUpdated = venue.lastUpdated {
						label.text = "Last updated: \(lastUpdated.convertToDateString())"
					} else {
						label.text = "Last updated: unknown"
					}
				default:
					break
			}
		}
	}
	
	
	
	//MARK: - Navigation
	
	@objc private func dismissVC() {
		dismiss(animated: true, completion: nil)
	}
}
