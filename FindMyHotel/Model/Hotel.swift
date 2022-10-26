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
	
	var suitesArray: [String] {
		suitesAvailability.components(separatedBy: ":")
	}

}
