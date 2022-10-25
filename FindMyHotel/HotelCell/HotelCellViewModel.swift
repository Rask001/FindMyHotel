//
//  HotelCellViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation

protocol HotelCellVMProtocol {
	var networkService: GettingHotelProtocol { get }
	
	var hotelName: String { get }
	var hotelAdress: String { get }
	var distance: String { get }
	var suitsAvalibaleCount: String { get }
	var stars: Double { get }

	func fetchImage(completion: @escaping(String) -> Void)

	init(hotel: Hotel)
}

class HotelCellViewModel: HotelCellVMProtocol {
	var networkService: GettingHotelProtocol = NetworkService()
	var hotelName: String {
		hotel.name
	}
	
	var distanceToCenter: String {
		"\(hotel.distance) meters to the center"
	}
	
	var availableSuites: String {
		"Available rooms: \(hotel.suitesArray.count)"
	}
	
	var stars: Double {
		hotel.stars
	}
	
	func fetchImage(completion: @escaping (String) -> Void) {
		networkService.fetchHotel(id: hotel.id) { result in
			switch result {
			case .success(let data):
				completion()
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
//		networkService. (with: hotel.id) { result in
//			switch result {
//
//			case .success(let data):
//				guard let imageURL = data.imageHandler else { return }
//				completion(imageURL)
//			case .failure(let error):
//				print(error.localizedDescription)
//			}
//		}
	}
	
	private let hotel: Hotel
	
	required init(hotel: Hotel) {
		self.hotel = hotel
	}
}
