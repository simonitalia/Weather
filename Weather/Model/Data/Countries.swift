//
//  Countries.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import UIKit

class Countries {
	var list = [Country]()
	
	init(venues: Venues) {
		list = venues.uniqueCountries()
	}
}
