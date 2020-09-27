//
//  MainViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class MainViewController: UIViewController {
	
	//MARK: Properties
	
	var weather: [Weather]?
	
	enum Identifier {
		enum Segue {
			static let mainVCToWeatherVC = "MainVCToWeatherVC"
			static let mainVCToCountriesTableVC = "MainVCToCountriesTableVC"
		}
		
		enum Storyboard {
			static let weatherVC = "WeatherVC"
			static let countriesNC = "CountriesNC"
		}
	}
	
	
	//MARK: - Storyboard Outlets
	
	@IBAction func filterButtonTapped(_ sender: Any) {
		
	}
	
	
	//MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureVC()
    }
	
	
	private func configureVC() {
		
	}
    
}

//MARK: - WeatherViewControllerDelegate

extension MainViewController: WeatherViewControllerDelegate {
	func updateWeatherData(with weather: [Weather]) {
		self.weather = weather
	}
}

//MARK: - Navigation

extension MainViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		switch segue.identifier {
			
			case Identifier.Segue.mainVCToWeatherVC:
				let vc = segue.destination as! WeatherViewController
				vc.delegate = self
				
			case Identifier.Segue.mainVCToCountriesTableVC:
				let vc = segue.destination as! CountriesTableViewController
				guard let weather = weather else { return }
				let countries = Countries(weather: weather)
				vc.countries = countries.list

			default:
				fatalError()
		}
	}
}
