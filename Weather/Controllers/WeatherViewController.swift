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
	
	private enum Section {
	   case main
	}
	
	
	lazy private var weather = [Weather]() {
		didSet {
			print("Weather Data fetch. With objects: \(weather.count)")
			updateUI()
		}
	}
	
	
	private var dataSource: UITableViewDiffableDataSource<Section, Weather>! //dataSource

	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureWeatherTableView()
		configureWeatherTableViewCell()
		fireGetWeatherFeed()
	}
	
	
	//MARK: - ViewController Configuration
	
	private func configureWeatherTableView() {
		weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
		weatherTableView.register(UINib(nibName: WeatherTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.reuseIdentifier)
		
		weatherTableView.delegate = self
	}
	
	
	private func configureWeatherTableViewCell() {
		
		self.dataSource = UITableViewDiffableDataSource<Section, Weather>(tableView: self.weatherTableView, cellProvider: { (tableView, indexPath, location) -> UITableViewCell? in
		
			let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeatherTableViewCell
			
			cell?.setTableCellContent(for: location)
			return cell
		})
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
	
	
	//MARK: - UI
	
	private func updateUI() {
		DispatchQueue.main.async {
			self.updateWeatherTableViewSnapshot()
		}
	}
}


//MARK: - Weather TableView DataSource

extension WeatherViewController {
	private func updateWeatherTableViewSnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Weather>()
		snapshot.appendSections([.main])
		snapshot.appendItems(self.weather)
		self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}


//MARK: - Weather TableView Delegate

extension WeatherViewController: UITableViewDelegate {
	
	
	
}

