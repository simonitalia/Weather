//
//  Country.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

// MARK: - Country Object

struct Country: Codable, Hashable {
	let countryID: String
	let name: String

	enum CodingKeys: String, CodingKey {
		case countryID = "_countryID"
		case name = "_name"
	}
}
