//
//  MainViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

protocol MainViewControllerDelegate {
	func updateVenuesDisplayed(with venues: [Venue])
}


class MainViewController: UIViewController {
	
	//MARK: - Storyboard Outlets
	@IBOutlet weak var filterButton: WButton!
	
	
	//MARK: Properties
	
	var delegate: MainViewControllerDelegate?
	
	//all venues fethed from remote server
	private var allVenues: Venues? {
		didSet {
			venuesDisplayed = allVenues?.list
		}
	}
	
	//venues diplayed on VenuesTableVC
	private var venuesDisplayed: [Venue]? {
		didSet {
			guard let venues = venuesDisplayed else { return }
			delegate?.updateVenuesDisplayed(with: venues)
		}
	}
	
	
	private enum Identifier {
		enum Segue {
			static let mainVCToVenuesVC = "MainVCToVenuesVC"
			static let mainVCToCountriesTableVC = "MainVCToCountriesTableVC"
		}
	}
	

	//MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		fireGetWeatherFeed()
		configureFilterButton(with: nil)
    }
	
	
	//MARK: - ConfigureViewController
	
	private func configureFilterButton(with countryName: String?) {
		filterButton.setButtonText(with: countryName)
	}
	
	
	private func fireGetWeatherFeed() {
		NetworkController.shared.getWeatherFeed { [unowned self] result in
			
			switch result {
				case .success(let venues):
					self.allVenues = venues
				
				case .failure(let error):
					print(error.rawValue)
			}
		}
	}
}


//MARK: - Navigation

extension MainViewController {
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		switch segue.identifier {
			
			case Identifier.Segue.mainVCToVenuesVC:
				let vc = segue.destination as! VenuesViewController
				vc.mainVC = self
				
			case Identifier.Segue.mainVCToCountriesTableVC:
				let vc = segue.destination as! CountriesTableViewController
				let countries = allVenues?.getUniqueCountries()
				vc.countries = countries
				vc.delegate = self

			default:
				break
		}
	}
}


//MARK: - CountriesTableViewController Delegate

extension MainViewController: CountriesTableViewControllerDelegate {
	
	func filterVenues(by country: Country) {
		let filterdVenues = allVenues?.filterList(by: country)
		venuesDisplayed = filterdVenues
		
		let name = country.name
		configureFilterButton(with: name)
	}
}

