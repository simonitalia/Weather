//
//  Venues.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import Foundation

struct Venues {
	var list: [Venue]
	
	init(list: [Venue]) {
		self.list = list
	}
}


extension Venues {
	
	func filterList(by country: Country) -> [Venue] {
		var filteredVenues = [Venue]()
		list.forEach {
			if $0.country.countryID == country.countryID {
				filteredVenues.append($0)
			}
		}
		
		return filteredVenues
	}
	
	
	func getUniqueCountries() -> [Country] {
		var countries = [Country]()
		
		self.list.forEach( { (item) in
			guard !countries.contains(item.country) else { return }
			countries.append(item.country)
		})
		
		return countries
	}
}
