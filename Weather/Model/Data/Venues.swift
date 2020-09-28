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
	
	enum SortKey: Int {
		case name = 0
		case temperature
		case lastUpdated
	}
	
	
	func filterList(by country: Country) -> [Venue] {
		var filteredVenues = [Venue]()
		list.forEach {
			if $0.country.countryID == country.countryID {
				filteredVenues.append($0)
			}
		}
		
		return filteredVenues
	}
	
	
	func uniqueCountries() -> [Country] {
		var countries = [Country]()
		
		self.list.forEach( { (item) in
			guard !countries.contains(item.country) else { return }
			countries.append(item.country)
		})
		
		return countries
	}
	
	static func sortedVenues(list: [Venue], using sortKey: SortKey) -> [Venue] {
	
		var sortedList = list
		
		switch sortKey  {
			case .name  :
				sortedList.sort { ($0.name) < ($1.name) }

			case .temperature:
				sortedList.sort {
					($0.temperature?.convertToInt() ?? 0) > ($1.temperature?.convertToInt() ?? 0) }
				
			case .lastUpdated:
				sortedList.sort { ($0.lastUpdated ?? 0) > ($1.lastUpdated ?? 0) }
		}
		
		return sortedList
	}
}
