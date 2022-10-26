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
		let suites = suitesAvailability.replacingOccurrences(of: ":", with: ", ")
		let text = "avalible rooms: \(suites)"
		return text
	}
	
	var suitesArray: [String] {
		let suites = suitesAvailability
		var transform = suites.components(separatedBy: ":").compactMap(Int.init)
		var str = transform.map {"\($0)"}
		return str
	}
}
