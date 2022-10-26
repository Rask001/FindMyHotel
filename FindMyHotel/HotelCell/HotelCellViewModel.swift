//
//  HotelCellViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

protocol HotelCellVMProtocol {
	
	var networkService: GettingHotelProtocol { get }
	var hotelName: String { get }
	var hotelAdress: String { get }
	var distance: String { get }
	var suitsAvalibaleCount: String { get }
	var stars: String { get }
	var hotel: Hotel { get }
	
	func fetchImage(completion: @escaping(UIImage) -> Void)
	
	init(hotel: Hotel)
}

class HotelCellViewModel: HotelCellVMProtocol {

	var networkService: GettingHotelProtocol = NetworkService()
	let hotel: Hotel
	required init(hotel: Hotel) {
		self.hotel = hotel
	}
	
	var hotelAdress: String {
		hotel.address
	}
	
	var distance: String {
		"📍\(hotel.distance)km from center"
	}
	
	var suitsAvalibaleCount: String {
		"Only \(hotel.suitesArray.count) rooms left"
	}
	
	var hotelName: String {
		hotel.name
	}
	
	var stars: String {
		Helper.starsToString(stars: hotel.stars)
	}
	
	func fetchImage(completion: @escaping (UIImage) -> Void) {
		networkService.fetchHotel(url: .getHotelUrl(withID: hotel.id)) { result in
			switch result {
			case .success(let data):
				guard let imageId = data.image else { return }
				let url: URL = .getImageUrl(withImageId: imageId)
				if let data = try? Data(contentsOf: url) {
					if let image = UIImage(data: data) {
						completion(image)
					}
				}
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
