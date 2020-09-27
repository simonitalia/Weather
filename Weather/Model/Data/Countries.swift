//
//  Countries.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import Foundation

struct Countries {
	var list = [Country]()
	
	init(weather: [Weather]) {
		weather.forEach( { (item) in
			guard !list.contains(item.country) else { return }
			list.append(item.country)
		})
	}
}
