//
//  Venue.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

//MARK: - Venue Object
struct Venue: Codable, Hashable {
	let venueID: String
	let name: String
	let country: Country
	let condition: String?
	let conditionIcon: String?
	let wind: String?
	let humidity: String?
	let temperature: String?
	let feelsLike: String?
	let sport: Sport
	let lastUpdated: Int?

	enum CodingKeys: String, CodingKey {
		case venueID = "_venueID"
		case name = "_name"
		case country = "_country"
		case condition = "_weatherCondition"
		case conditionIcon = "_weatherConditionIcon"
		case wind = "_weatherWind"
		case humidity = "_weatherHumidity"
		case temperature = "_weatherTemp"
		case feelsLike = "_weatherFeelsLike"
		case sport = "_sport"
		case lastUpdated = "_weatherLastUpdated"
	}
}
