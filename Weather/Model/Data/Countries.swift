//
//  Countries.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import UIKit

class Countries {
	var list = [Country]()
	
	init(venues: Venues) {
		list = venues.getUniqueCountries()
	}
}


extension Countries {
	private enum Flag: String {
		case australia = "16"
		case hongKong = "96"
		case ireland = "106"
		case newZealand = "170"
		case singapore = "194"
		case unitedKingdom = "79"
	}

	class func getFlagImage(for countryID: String) -> UIImage? {
		let id = Flag.init(rawValue: countryID)
		
		switch id {
			case .australia:
				return UIImage(named: "flag-australia")
				   
			case .hongKong:
				return UIImage(named: "flag-hong-kong")

			case .singapore:
				return UIImage(named: "flag-singapore")

		   case .ireland:
				return UIImage(named: "flag-ireland")

		   case .newZealand:
				return UIImage(named: "flag-new-zealand")

			case .unitedKingdom:
				return UIImage(named: "flag-united-kingdom")
				
			default:
				return nil
		}
	}
}
