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
	
	@IBAction func filterButtonTapped(_ sender: Any) {
		presentCountriesViewController()
	}
	
	@IBAction func refreshBarButtonTapped(_ sender: UIBarButtonItem) {
		fireGetWeatherFeed()
	}
	
	
	
	//MARK: Properties
	
	var delegate: MainViewControllerDelegate?
	
	//all venues fethed from remote server
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
	
	
	private enum Identifier {
		enum Segue {
			static let mainVCToVenuesVC = "MainVCToVenuesVC"
		}
		
		enum Storyboard {
			static let countriesTableVC = "CountriesTableVC"
		}
	}
	

	//MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigationBar()
		fireGetWeatherFeed()
    }
	
	
	//MARK: - ViewController Configuration
	
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
	
	
	//MARK: UI Configuration
	
	private func configureNavigationBar() {
		title = "Weather"
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
			
			let countries = allVenues?.getUniqueCountries()
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
