//
//  Constants.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import Foundation

struct Constants {
	
	enum ImageAsset {
		
		enum Flag {
			static let australia = "flag-australia"
			static let hongKong = "flag-hong-kong"
			static let ireland = "flag-ireland"
			static let newZealand = "flag-new-zealand"
			static let singapore = "flag-singapore"
			static let unitedKingdom = "flag-united-kingdom"
			
		}
		
		enum ConditionIcon {
			static let clear = "conditionIcon-clear"
			static let fog = "conditionIcon-fog"
			static let hazy = "conditionIcon-hazy"
			static let mostlyCloudy = "conditionIcon-mostlycloudy"
			static let partlyCloudy = "conditionIcon-partlycloudy"
			static let rain = "conditionIcon-rain"
			static let thunderStorms = "conditionIcon-tstorms"
		}
	}
}
