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
	let suites_availability: String
	let lat: Double?
	let lon: Double?
	
	func getImage(id: Int) -> String {
		return "https://github.com/iMofas/ios-android-test/raw/master/\(id).jpg"
	}
	
	var suitesArray: [String] {
		suites_availability.components(separatedBy: ":")
	}

}
