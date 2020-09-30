//
//  Constants.swift
//  Weather
//
//  Created by Simon Italia on 9/28/20.
//

import UIKit

struct Constants {
	
	private init(){}//guard from initialization
	
	enum Text {
		static let noText = "-"
		static let unknownText = "unknown"
		
		static func setDefaultText(prefix: String?) -> String {
			if let prefix = prefix {
				return "\(prefix): \(Text.noText)"
			} else {
				return Text.noText
			}
		}
	}
	
	enum AssetType {
		enum CountryFlag {
			static let australia = "flag-australia" //id = 16
			static let hongKong = "flag-hong-kong" //id = 96
			static let ireland = "flag-ireland" //id = 106
			static let newZealand = "flag-new-zealand" //id = 170
			static let singapore = "flag-singapore" //id = 194
			static let unitedKingdom = "flag-united-kingdom" //id = 79
			
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
		
		static let defaultImage = "no-image"
		
		
		case flag(id: String)
		case conditionIcon(named: String)
		
		var filename: String? {
			switch self {
				case .flag(let id):
				switch id {
					case "16":
						return AssetType.CountryFlag.australia
					case "96":
						return AssetType.CountryFlag.hongKong
					case "106":
						return AssetType.CountryFlag.ireland
					case "170":
						return AssetType.CountryFlag.newZealand
					case "194":
						return AssetType.CountryFlag.singapore
					case "79":
						return AssetType.CountryFlag.unitedKingdom
					default:
						return AssetType.defaultImage
				}
				
				case .conditionIcon(let name):
				switch name {
					case "clear":
						return AssetType.ConditionIcon.clear
					case "fog":
						return AssetType.ConditionIcon.fog
					case "hazy":
						return AssetType.ConditionIcon.hazy
					case "mostlycloudy":
						return AssetType.ConditionIcon.mostlyCloudy
					case "partlycloudy":
						return AssetType.ConditionIcon.partlyCloudy
					case "rain":
						return AssetType.ConditionIcon.rain
					case "tstorms":
						return AssetType.ConditionIcon.thunderStorms
					default:
						return AssetType.defaultImage
				}
			}
		}
		
		var image: UIImage? {
			guard let filename = filename else { return nil }
			return UIImage(named: filename)
		}
		
		
		static func getImage(for assetType: AssetType) -> UIImage? {
			
			switch assetType {
				case .flag(let id):
					return AssetType.flag(id: id).image
					
				case .conditionIcon(let name):
					return AssetType.conditionIcon(named: name).image
			}
		}
	}
}
