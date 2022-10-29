//
//  HotelCellViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

final class HotelCellViewModel: HotelCellVMProtocol {
	
	//MARK: - PROPERTY
	var networkService: GettingHotelProtocol = NetworkService()
	let hotel: Hotel
	required init(hotel: Hotel) {
		hotel = hotel
	}
	
	var hotelAdress: String {
		hotel.address
	}
	
	var distance: String {
		"📍\(hotel.distance)km from center"
	}
	
	var suitsAvalibaleCount: String {
		if hotel.suitesArray.count > 1 {
			return "Only \(hotel.suitesArray.count) rooms left"
		} else {
			return "Only \(hotel.suitesArray.count) room left"
		}
	}
	
	var hotelName: String {
		hotel.name
	}
	
	var stars: String {
		Helper.starsToString(stars: hotel.stars)
	}
	
	//MARK: - ACTIONS
	func fetchImage(completion: @escaping (UIImage) -> Void) {
		networkService.fetchHotel(url: .getHotelUrl(withID: hotel.id)) { result in
			ImageDownloader.shared.imageDownloadAndCahed(result: result) { image in
				completion(image)
			}
			
		}
	}
	
}
