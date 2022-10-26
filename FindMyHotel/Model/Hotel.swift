//
//  Hotel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation

struct Hotel: Decodable {
	let id: Int
	let name: String
	let address: String
	let stars: Double
	let distance: Double
	var image: String?
	let suitesAvailability: String
	let lat: Double?
	let lon: Double?
	
	var suites: String {
		let suites: String
		let text: String
		
		if suitesAvailability.count < 3 {
			suites = suitesAvailability.replacingOccurrences(of: ":", with: "")
			text = "avalible room: \(suites)"
		} else {
			suites = suitesAvailability.replacingOccurrences(of: ":", with: ", ")
			text = "avalible rooms: \(suites)"
		}
		return text
	}
	
	var suitesArray: [Int] {
				var transform = suites.components(separatedBy: ":").compactMap(Int.init)
				return transform
			}
	}

