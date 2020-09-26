//
//  ViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/25/20.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var weather = [Weather]()

	override func viewDidLoad() {
		super.viewDidLoad()
		getWeather()
	}
	
	
	private func getWeather() {
		NetworkController.shared.getWeatherFeed { [unowned self] result in
			switch result {
				case .success(let weather):
					self.weather = weather
		
				//display alert to user on error
				case .failure(let error):
					print(error.rawValue)

			}
		}
	}
}

