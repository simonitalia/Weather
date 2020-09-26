//
//  ViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/25/20.
//

import UIKit


protocol WeatherViewControllerDelegate {
	func updateWeatherData(with weather: [Weather])
}


class WeatherViewController: UIViewController {
	
	private enum WeatherTableViewSection {
	   case main
	}
	
	
	//MARK: - Storyboard Connections

	@IBOutlet weak var weatherTableView: UITableView!
	
	
	//MARK: - Class Properties
	var delegate: WeatherViewControllerDelegate?

	lazy private var weather = [Weather]() {
		didSet {
			updateUI()
			delegate?.updateWeatherData(with: weather)
				//update parent / mainVC data property
		}
	}
	
	
	private var dataSource: UITableViewDiffableDataSource<WeatherTableViewSection, Weather>! //dataSource

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
		
		self.dataSource = UITableViewDiffableDataSource<WeatherTableViewSection, Weather>(tableView: self.weatherTableView, cellProvider: { (tableView, indexPath, location) -> UITableViewCell? in
		
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
		var snapshot = NSDiffableDataSourceSnapshot<WeatherTableViewSection, Weather>()
		snapshot.appendSections([.main])
		snapshot.appendItems(self.weather)
		self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}


//MARK: - Weather TableView Delegate

extension WeatherViewController: UITableViewDelegate {
	
	
	
}

