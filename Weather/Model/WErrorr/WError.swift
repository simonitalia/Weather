//
//  WError.swift
//  Weather
//
//  Created by Simon Italia on 9/26/20.
//

import Foundation

enum WError: String, Error {
	case invalidResponse = "Invalid response from server. Please try again."
	case unableToComplete = "Unable to complete request. Please check internet connection."
	case invalidData = "Data from server was invalid. Please try again."
}
