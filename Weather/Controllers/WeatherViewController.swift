//
//  ViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/25/20.
//

import UIKit

class WeatherViewController: UIViewController {
	
	//MARK: - Storyboard Connections
	
	@IBOutlet weak var weatherTableView: UITableView!
	
	
	//MARK: - Class Properties
	
	lazy var weather = [Weather]()

	
	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureWeatherTableView()
		fireGetWeatherFeed()
	}
	
	
	//MARK: - ViewController Configuration
	
	private func configureWeatherTableView() {
		weatherTableView.dataSource = self
		weatherTableView.delegate = self
	}
	
	
	private func fireGetWeatherFeed() {
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


//MARK: - Weather TableView Delegates

extension WeatherViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	
}


extension WeatherViewController: UITableViewDelegate {
	
	
	
}

