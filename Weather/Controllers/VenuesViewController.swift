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
	private var dataSource: UITableViewDiffableDataSource<VenuesTableViewSection, Venue>? //dataSource
	private var venues: [Venue]? {
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
		venuesTableView.delegate = self
	}
	
	
	private func configureVenuesTableViewCell() {
		self.dataSource = UITableViewDiffableDataSource<VenuesTableViewSection, Venue>(tableView: self.venuesTableView, cellProvider: { (tableView, indexPath, location) -> UITableViewCell? in
		
			let cell = tableView.dequeueReusableCell(withIdentifier: VenuesTableViewCell.reuseIdentifier, for: indexPath) as? VenuesTableViewCell
			
			cell?.setContent(for: location)
			return cell
		})
	}

	
	//MARK: - UI Configuration
	
	private func updateUI() {
		DispatchQueue.main.async { [unowned self] in
			self.updateVenuesTableViewSnapshot()
		}
	}
}


//MARK: - Venues TableView DataSource

extension VenuesViewController {
	private func updateVenuesTableViewSnapshot() {
		guard let venues = self.venues else { return }
		var snapshot = NSDiffableDataSourceSnapshot<VenuesTableViewSection, Venue>()
		snapshot.appendSections([.main])
		snapshot.appendItems(venues)
		self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}


//MARK: - MainViewControllerDelegate Delegate

extension VenuesViewController: MainViewControllerDelegate {
	func updateVenuesDisplayed(with venues: [Venue]) {
		self.venues = venues
	}
}

//MARK: - VenuesViewController TableViewDelegate

extension VenuesViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let venues = self.venues else { return }
		
		let venue = venues[indexPath.row]
		presentVenueDetailsViewController(passingObject: venue)
	}
	
}


//MARK: - Navigation

extension VenuesViewController {
	private func presentVenueDetailsViewController(passingObject venue: Venue) {
		//setup destinationVC
		let vc = self.storyboard?.instantiateViewController(withIdentifier: Identifier.Storyboard.venueDetailsVC) as! VenueDetailsViewController
		vc.venue = venue
		
		
		let nc = UINavigationController(rootViewController: vc)
		nc.modalPresentationStyle = .fullScreen
		
		present(nc, animated: true, completion: nil)
	}
}
