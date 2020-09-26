//
//  MainViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class MainViewController: UIViewController {
	
	enum Identifier {
		enum Segue {
			static let mainVCToWeatherVC = "MainVCToWeatherVC"
			static let mainVCToCountriesVC = "MainVCToCountriesVC"
		}
	}
	
	
	//MARK: - Storyboard Outlets
	
	@IBAction func filterButtonTapped(_ sender: Any) {
		
	}
	
	lazy var weather = [Weather]() {
		didSet {
			print("Countries set by childVC")
		}
	}
	
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
		if segue.identifier == Identifier.Segue.mainVCToWeatherVC {
			let vc = segue.destination as! WeatherViewController
			vc.delegate = self
		}
	}
}
