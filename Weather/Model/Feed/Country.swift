//
//  Country.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

// MARK: - Country Object
struct Country: Codable {
	let countryID: String
	let name: String

	enum CodingKeys: String, CodingKey {
		case countryID = "_countryID"
		case name = "_name"
	}
}

extension Country {
	enum Name: String, Codable {
		case australia = "Australia"
		case hongKong = "Hong Kong"
		case ireland = "Ireland"
		case newZealand = "New Zealand"
		case singapore = "Singapore"
		case unitedKingdom = "United Kingdom"
	}
}
