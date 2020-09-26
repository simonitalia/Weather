//
//  Sport.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

struct Sport: Codable {
	let sportID: String
	let description: String

	enum CodingKeys: String, CodingKey {
		case sportID = "_sportID"
		case description = "_description"
	}
}

extension Sport {
	enum Description: String, Codable {
		case horseRacing = "Horse Racing"
	}
}
