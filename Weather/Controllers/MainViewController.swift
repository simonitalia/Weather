//
//  MainViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class MainViewController: UIViewController {
	
	//MARK: Properties
	
	var venues: [Venue]?
	
	private enum Identifier {
		enum Segue {
			static let mainVCToVenuesVC = "MainVCToVenuesVC"
			static let mainVCToCountriesTableVC = "MainVCToCountriesTableVC"
		}
	}
	

	//MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureVC()
    }
	
	
	private func configureVC() {
		
	}
    
}

//MARK: - VenuesViewControllerDelegate

extension MainViewController: VenuesViewControllerDelegate {
	func updateVenuesData(with venues: [Venue]) {
		self.venues = venues
	}
}

//MARK: - Navigation

extension MainViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		switch segue.identifier {
			
			case Identifier.Segue.mainVCToVenuesVC:
				let vc = segue.destination as! VenuesViewController
				vc.delegate = self
				
			case Identifier.Segue.mainVCToCountriesTableVC:
				let vc = segue.destination as! CountriesTableViewController
				guard let venues = venues else { return }
				let countries = Countries(venues: venues)
				vc.countries = countries.list

			default:
				break
		}
	}
}
