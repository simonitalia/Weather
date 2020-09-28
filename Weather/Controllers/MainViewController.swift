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
	
	private enum Identifier {
		enum Segue {
			static let mainVCToVenuesVC = "MainVCToVenuesVC"
		}
		
		enum Storyboard {
			static let countriesTableVC = "CountriesTableVC"
		}
	}
	
	
	//MARK: - Storyboard Connections
	
	@IBOutlet weak var activitySpinner: WActivityIndicatorView!
	@IBAction func refreshBarButtonTapped(_ sender: UIBarButtonItem) {
		fireGetWeatherFeed()
	}
	
	@IBOutlet var sortByButtons: [WSortByButton]!
	@IBAction func sortByButtonTapped(_ sender: WSortByButton) {
		guard let venues = venuesDisplayed else { return }
		
		switch sender.tag {
			case 0:
				self.venuesDisplayed = Venues.sortedVenues(list: venues, using: .name)
			
			case 1:
				self.venuesDisplayed = Venues.sortedVenues(list: venues, using: .temperature)
				
			case 2:
				self.venuesDisplayed = Venues.sortedVenues(list: venues, using: .lastUpdated)
			default:
				break
		}
	}
	
	@IBOutlet weak var filterButton: WFilterButton!
	@IBAction func filterButtonTapped(_ sender: Any) {
		presentCountriesViewController()
	}
	
	
	//MARK: Properties
	
	var delegate: MainViewControllerDelegate?
	
	//all venues fetched from remote server
	private var allVenues: Venues? {
		didSet {
			venuesDisplayed = allVenues?.list
			configureFilterButton(with: nil)
		}
	}
	
	//venues diplayed on VenuesTableVC
	private var venuesDisplayed: [Venue]? {
		didSet {
			guard let venues = venuesDisplayed else { return }
			delegate?.updateVenuesDisplayed(with: venues)
		}
	}
	
	
	//MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigationBar()
		fireGetWeatherFeed()
		configureSortByButtons()
    }
	
	
	//MARK: - ViewController Configuration
	
	private func fireGetWeatherFeed() {
		enableUserInteraction(false)
		activitySpinner.animateSpinner(true)
		
		NetworkController.shared.getWeatherFeed { [unowned self] result in
			
			self.activitySpinner.animateSpinner(false)
			self.enableUserInteraction(true)
			
			switch result {
				case .success(let venues):
					self.allVenues = venues
					
				case .failure(let error):
					print(error.rawValue)
			}
		}
	}
	
	
	//MARK: - UI Configuration
	
	private func enableUserInteraction(_ bool: Bool) {
		DispatchQueue.main.async { [unowned self] in
			self.view.isUserInteractionEnabled = bool
		}
	}
	
	
	private func configureNavigationBar() {
		title = "Weather"
	}
	

	private func configureSortByButtons() {
		sortByButtons.forEach { ($0.setButtonText(for: $0)) }
	}
	

	private func configureFilterButton(with countryName: String?) {
		DispatchQueue.main.async { [unowned self] in
			filterButton.setButtonText(with: countryName)
		}
	}
	
}


//MARK: - Navigation

extension MainViewController {
	
	//Child VC / VenuesVC
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Identifier.Segue.mainVCToVenuesVC {
			let vc = segue.destination as! VenuesViewController
			vc.mainVC = self
		}
	}
	
	
	//CountriesVC
	private func presentCountriesViewController() {
		if let vc = storyboard?.instantiateViewController(withIdentifier: Identifier.Storyboard.countriesTableVC) as? CountriesTableViewController {
			
			let countries = allVenues?.uniqueCountries()
			vc.countries = countries
			vc.delegate = self
			
			let nc = UINavigationController(rootViewController: vc)
			present(nc, animated: true)
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
