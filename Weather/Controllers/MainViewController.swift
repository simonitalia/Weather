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
	
	@IBOutlet var sortByButtons: [WButtonSortBy]!
	@IBAction func sortByButtonTapped(_ sender: WButtonSortBy) {
		
		var sortedVenues = [Venue]()
		
		switch sender.tag {
			case 0:
				sortedVenues = Venues.sortedVenues(list: venuesDisplayed, using: .name)
			
			case 1:
				sortedVenues = Venues.sortedVenues(list: venuesDisplayed, using: .temperature)
				
			case 2:
				sortedVenues = Venues.sortedVenues(list: venuesDisplayed, using: .lastUpdated)
				
			default:
				break
		}
		
		updateDisplayedVenuesData(with: sortedVenues)
	}
	
	
	@IBOutlet weak var filterButton: WButtonFilter!
	@IBAction func filterButtonTapped(_ sender: Any) {
		presentCountriesViewController()
	}
	
	
	//MARK: Properties
	
	var delegate: MainViewControllerDelegate?
	
	//all venues fetched from remote server
	private var allVenues: Venues? {
		didSet {
			configureFilterButton(with: nil)
			updateDisplayedVenuesData(with: allVenues?.list ?? [])
		}
	}
	
	//venues diplayed on child VenuesTableVC
	private lazy var venuesDisplayed = [Venue]() {
		didSet {
			delegate?.updateVenuesDisplayed(with: venuesDisplayed)
		}
	}
	
	
	//MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		fireGetWeatherFeed()
		configureNavigationBar()
		configureSortByButtons()
    }
	
	
	//MARK: - DataSources Management
	private func updateAllVenuesData(with allVenues: Venues?) {
		self.allVenues = allVenues
	}
	
	
	private func updateDisplayedVenuesData(with venues: [Venue]) {
		venuesDisplayed = venues
	}
	
	
	@objc private func fireGetWeatherFeed() {
		if allVenues != nil { updateAllVenuesData(with: nil) } //reset displayed data
		
		enableUserInteraction(false)
		activitySpinner.animateSpinner(true)
		
		NetworkController.shared.getWeatherFeed { [unowned self] result in
			
			self.activitySpinner.animateSpinner(false)
			self.enableUserInteraction(true)
			
			switch result {
				case .success(let allVenues):
					self.updateAllVenuesData(with: allVenues)
					
				case .failure(let error):
					self.presentAlert(title: "We had a problem!", message: error.rawValue, completionHandler: #selector(self.fireGetWeatherFeed))
			}
		}
	}
	
	
	//MARK: - UI Configuration
	
	private func enableUserInteraction(_ bool: Bool) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
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
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.filterButton.setButtonText(with: countryName)
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
		guard let filterdVenues = allVenues?.filterList(by: country) else { return }
		updateDisplayedVenuesData(with: filterdVenues)
		
		let name = country.name
		configureFilterButton(with: name)
	}
}
