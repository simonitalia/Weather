//
//  String+Extensions.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

extension String {
	
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
	
	func convertToInt() -> Int {
		return Int(self) ?? 0
	}
	
	func dropPrefix(_ prefix: String) -> String {
		guard self.hasPrefix(prefix) else { return self }
		return String(self.dropFirst(prefix.count))
	}
}
