//
//  Int+Extensions.swift
//  Weather
//
//  Created by Simon Italia on 9/29/20.
//

import Foundation

extension Int {
	func convertToDateString() -> String {
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		let formatter = DateFormatter()
		formatter.dateFormat =  "HH:mm E, d MMM y"
		return formatter.string(from: date)
	}
}
