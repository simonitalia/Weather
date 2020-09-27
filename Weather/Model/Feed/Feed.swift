//
//  Feed.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

// MARK: - Data Feed Object
struct Feed: Codable {
	let result: Bool
	let status: Bool
	let data: [Venue]
	
	enum CodingKeys: String, CodingKey {
		case result = "ret"
		case status = "isOkay"
		case data
	}
}

