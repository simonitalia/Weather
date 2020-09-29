//
//  CountriesTableViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit


protocol CountriesTableViewControllerDelegate {
	func filterVenues(by country: Country)
}

class CountriesTableViewController: UITableViewController {
	

	//MARK: - Storyboard Connections
	
	@IBOutlet var countriesTableView: UITableView!
	
	
	//MARK: - Properties
	var countries: [Country]?
	private var filterCountry: Country?
	var delegate: CountriesTableViewControllerDelegate?

	
	//MARK: - View Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigationBar()
		configureCountriesTableView()
    }
	
	
	//MARK: - UI Configuration
	
	private func configureNavigationBar() {
		title = "Filter by Country"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
	}
	
	
	private func configureCountriesTableView() {
		countriesTableView.register(UINib(nibName: CountriesTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CountriesTableViewCell.reuseIdentifier)
		
		countriesTableView.tableFooterView = UIView() //hides empty rows
	}
}


// MARK: - TableView DataSource

extension CountriesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries?.count ?? 0
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
        let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseIdentifier, for: indexPath) as! CountriesTableViewCell
		
		if let countries = self.countries {
			let country = countries[indexPath.row]
			cell.setContent(with: country)
		}
		
		return cell
    }
}


//MARK: - TableView Delegate

extension CountriesTableViewController {
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let countries = self.countries {
			let country = countries[indexPath.row]
			filterCountry = country
		}
		
		dismissVC()
	}
}


//MARK: - Navigation

extension CountriesTableViewController {
	@objc func dismissVC() {
		if let country = filterCountry {
			delegate?.filterVenues(by: country)
		}
		
		dismiss(animated: true, completion: nil)
	}
}
