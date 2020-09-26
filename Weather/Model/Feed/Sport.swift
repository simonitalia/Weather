//
//  Sport.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

struct Sport: Codable, Hashable {
	let sportID: String
	let description: String

	enum CodingKeys: String, CodingKey {
		case sportID = "_sportID"
		case description = "_description"
	}
}
