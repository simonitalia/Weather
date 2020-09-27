//
//  ViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/25/20.
//

import UIKit


protocol VenuesViewControllerDelegate {
	func updateVenuesData(with venues: [Venue])
}


class VenuesViewController: UIViewController {
	
	//MARK: - Properties
	
	private enum VenuesTableViewSection {
	   case main
	}
	
	var delegate: VenuesViewControllerDelegate?
	
	private var dataSource: UITableViewDiffableDataSource<VenuesTableViewSection, Venue>! //dataSource

	lazy private var venues = [Venue]() {
		didSet {
			updateUI()
			delegate?.updateVenuesData(with: venues)
				//update parent / mainVC data property
		}
	}
	
	
	//MARK: - Storyboard Connections

	@IBOutlet weak var venuesTableView: UITableView!
	

	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVenuesTableView()
		configureVenuesTableViewCell()
		fireGetWeatherFeed()
	}
	
	
	//MARK: - ViewController Configuration
	
	private func configureVenuesTableView() {
		venuesTableView.register(UINib(nibName: VenuesTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: VenuesTableViewCell.reuseIdentifier)
		
		venuesTableView.delegate = self
	}
	
	
	private func configureVenuesTableViewCell() {
		
		self.dataSource = UITableViewDiffableDataSource<VenuesTableViewSection, Venue>(tableView: self.venuesTableView, cellProvider: { (tableView, indexPath, location) -> UITableViewCell? in
		
			let cell = tableView.dequeueReusableCell(withIdentifier: VenuesTableViewCell.reuseIdentifier, for: indexPath) as? VenuesTableViewCell
			
			cell?.setContent(for: location)
			return cell
		})
	}
	
	
	private func fireGetWeatherFeed() {
		NetworkController.shared.getWeatherFeed { [unowned self] result in
			
			switch result {
				case .success(let venues):
					self.venues = venues
				
				case .failure(let error):
					print(error.rawValue)
			}
		}
	}
	
	
	//MARK: - UI
	
	private func updateUI() {
		DispatchQueue.main.async {
			self.updateVenuesTableViewSnapshot()
		}
	}
}


//MARK: - Venues TableView DataSource

extension VenuesViewController {
	private func updateVenuesTableViewSnapshot() {
		var snapshot = NSDiffableDataSourceSnapshot<VenuesTableViewSection, Venue>()
		snapshot.appendSections([.main])
		snapshot.appendItems(self.venues)
		self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}


//MARK: - Venues TableView Delegate

extension VenuesViewController: UITableViewDelegate {
	
	
	
}

