//
//  Countries.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import UIKit

class Countries {
	var list = [Country]()
	
	init(venues: [Venue]) {
		venues.forEach( { (item) in
			guard !list.contains(item.country) else { return }
			list.append(item.country)
		})
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
		switch countryID {
			case Flag.australia.rawValue:
				return UIImage(named: "flag-australia")
				   
		   case Flag.hongKong.rawValue:
				return UIImage(named: "flag-hong-kong")
				   
			case Flag.singapore.rawValue:
				return UIImage(named: "flag-singapore")
			   
		   case Flag.ireland.rawValue:
				return UIImage(named: "flag-ireland")
				   
		   case Flag.newZealand.rawValue:
				return UIImage(named: "flag-new-zealand")
				   
			case Flag.unitedKingdom.rawValue:
				return UIImage(named: "flag-united-kingdom")
				
			default:
				return nil
		}
	}
}
