//
//  CountriesTableViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import UIKit

class CountriesTableViewController: UITableViewController {
	

	//MARK: - Storyboard Connections
	
	@IBOutlet var countriesTableView: UITableView!
	
	
	//MARK: - Class Properties
	lazy var countries = [Country]()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	
	//MARK: - ViewController Configuration
	
	private func configureWeatherTableView() {
		countriesTableView.register(CountriesTableViewCell.self, forCellReuseIdentifier: CountriesTableViewCell.reuseIdentifier)
		countriesTableView.register(UINib(nibName: CountriesTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CountriesTableViewCell.reuseIdentifier)
	}
}


// MARK: - Table view DataSource
extension CountriesTableViewController {

	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries.count
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseIdentifier, for: indexPath) as! CountriesTableViewCell
		
		let country = countries[indexPath.row]
		cell.setTableCellContent(for: country)
        return cell
    }
}
