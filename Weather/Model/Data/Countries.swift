//
//  Countries.swift
//  Weather
//
//  Created by Simon Italia on 9/27/20.
//

import UIKit

class Countries {
	var list = [Country]()
	
	init(weather: [Weather]) {
		weather.forEach( { (item) in
			guard !list.contains(item.country) else { return }
			list.append(item.country)
		})
	}
	
}


extension Countries {
	private enum Flag: String {
		case australia = "16"
		case hongKong = "96"
		case singapore = "106"
		case ireland = "170"
		case newZealand = "194"
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
