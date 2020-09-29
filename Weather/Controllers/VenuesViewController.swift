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
	
	private enum Identifier {
		enum Storyboard {
			static let venueDetailsVC = "VenueDetailsVC"
		}
	}
	
	var mainVC: MainViewController?
	
	//TableView Data DataSource
	private typealias Snapshot = NSDiffableDataSourceSnapshot<VenuesTableViewSection, Venue>
	private typealias DataSource = UITableViewDiffableDataSource<VenuesTableViewSection, Venue>
	private var dataSource: DataSource?
	
	//TableView Data
	private lazy var venues = [Venue]() {
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
		makeDataSource()
	}
	
	
	//MARK: - ViewController Configuration
	
	private func configureVenuesTableView() {
		venuesTableView.register(UINib(nibName: VenuesTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: VenuesTableViewCell.reuseIdentifier)
	
		mainVC?.delegate = self
		venuesTableView.delegate = self
	}
	
	
	//MARK: - UI Configuration
	
	private func updateUI() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.updateSnapshot()
		}
	}
}


//MARK: - Venues TableView DataSource

extension VenuesViewController {
	
	private func makeDataSource() {
		let dataSource = DataSource(tableView: self.venuesTableView, cellProvider: { (tableView, indexPath, venue) -> UITableViewCell? in
		
			let cell = tableView.dequeueReusableCell(withIdentifier: VenuesTableViewCell.reuseIdentifier, for: indexPath) as? VenuesTableViewCell
			
			cell?.setContent(for: venue)
			return cell
		})
		
		self.dataSource = dataSource
	}
	
	private func updateSnapshot() {
		var snapshot = Snapshot()
		snapshot.appendSections([.main])
		snapshot.appendItems(venues)
		self.dataSource?.apply(snapshot, animatingDifferences: true) { [weak self] in
			guard let self = self else { return }
			self.venuesTableView.reloadData() //shouldn't be required, but issue with animating UI table changes
		}
	}
}


//MARK: - VenuesViewController TableViewDelegate

extension VenuesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let venue = venues[indexPath.row]
		presentVenueDetailsViewController(passingObject: venue)
	}
}


//MARK: - MainViewControllerDelegate Delegate

extension VenuesViewController: MainViewControllerDelegate {
	func updateVenuesDisplayed(with venues: [Venue]) {
		self.venues = venues
	}
}


//MARK: - Navigation

extension VenuesViewController {
	private func presentVenueDetailsViewController(passingObject venue: Venue) {
		let vc = self.storyboard?.instantiateViewController(withIdentifier: Identifier.Storyboard.venueDetailsVC) as! VenueDetailsViewController
		vc.venue = venue
		
		let nc = UINavigationController(rootViewController: vc)
		nc.modalPresentationStyle = .fullScreen
		
		present(nc, animated: true, completion: nil)
	}
}
