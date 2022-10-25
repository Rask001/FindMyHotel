//
//  Hotel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation

struct Hotel: Codable {
	let id: Int
	let name: String
	let address: String
	let stars: Double
	let distance: Double
	var imageUrl: String = ""
	let suitesAvailability: String
	let lat: Double?
	let lon: Double?
//	let decoder = JSONDecoder()
//	decoder.keyDecodingStrategy = .convertFromSnakeCase
	init() {
		self.imageUrl = "https://github.com/iMofas/ios-android-test/raw/master/\(id).jpg"
	}
	
	var suitesArray: [String] {
		suitesAvailability.components(separatedBy: ":")
	}

}
