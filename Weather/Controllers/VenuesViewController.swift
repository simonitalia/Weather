//
//  ViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/25/20.
//

import UIKit


class VenuesViewController: UIViewController {
	
	//MARK: - Properties
	
	private enum VenuesTableViewSection {
	   case main
	}
	
	var mainVC: MainViewController?
	
	private var dataSource: UITableViewDiffableDataSource<VenuesTableViewSection, Venue>! //dataSource

	private var venues: [Venue]! {
		didSet {
			updateUI()
		}
	}
	
	
	//MARK: - Storyboard Connections

	@IBOutlet weak var venuesTableView: UITableView!
	

	//MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVenuesTableView()
		configureVenuesTableViewCell()
	}
	
	
	//MARK: - ViewController Configuration
	
	private func configureVenuesTableView() {
		venuesTableView.register(UINib(nibName: VenuesTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: VenuesTableViewCell.reuseIdentifier)
	
		mainVC?.delegate = self
	}
	
	
	private func configureVenuesTableViewCell() {
		self.dataSource = UITableViewDiffableDataSource<VenuesTableViewSection, Venue>(tableView: self.venuesTableView, cellProvider: { (tableView, indexPath, location) -> UITableViewCell? in
		
			let cell = tableView.dequeueReusableCell(withIdentifier: VenuesTableViewCell.reuseIdentifier, for: indexPath) as? VenuesTableViewCell
			
			cell?.setContent(for: location)
			return cell
		})
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


//MARK: - MainViewControllerDelegate Delegate

extension VenuesViewController: MainViewControllerDelegate {
	func updateVenuesDisplayed(with venues: [Venue]) {
		self.venues = venues
	}
}
