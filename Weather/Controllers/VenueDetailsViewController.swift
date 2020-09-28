//
//  VenueDetailsViewController.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import UIKit


class VenueDetailsViewController: UIViewController {
	
	var venue: Venue?

    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigationBar()
    }
    
	
	//MARK: - ViewController Configuration

	private func configureNavigationBar() {
		title = venue?.name ?? "Weather"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
	}
	
	
	//MARK: - Navigation
	
	@objc private func dismissVC() {
		dismiss(animated: true, completion: nil)
	}
    

}
