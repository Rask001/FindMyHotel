//
//  DetailViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation

import Foundation
import UIKit

class DetailViewModel: DetailViewModelProtocol {
	
	//MARK: - PROPERTY
	var networkService: GettingHotelProtocol = NetworkService()
	var hotel: Hotel
	required init(hotel: Hotel) {
		self.hotel = hotel
	}
	
	var hotelAdress: String {
		hotel.address
	}
	
	var distance: String {
		"📍\(hotel.distance)km from center"
	}
	
	var hotelName: String {
		hotel.name
	}
	
	var stars: String {
		Helper.starsToString(stars: hotel.stars)
	}
	
	//MARK: - ACTIONS
	func fetchImage(completion: @escaping (UIImage) -> Void) {
		networkService.fetchHotel(url: .getHotelUrl(withID: hotel.id)) { [weak self] result in
			guard let self else { return }
			self.networkService.imageDownloadAndCahed(result: result) { image in
				completion(image)
			}
		}
	}
	
	func fetchHotelForDetailView(completion: @escaping () -> Void) {
		networkService.fetchHotel(url: .getHotelUrl(withID: hotel.id)) { result in
			switch result {
			case .success(let data):
				self.hotel = data
				completion()
			case .failure(let error):
				print(error.localizedDescription)
				completion()
			}
		}
	}
	
//	func formatSuites() -> String {
//		
//	}
	
	func numberOfRows() -> Int {
		hotel.suitesArray.count
	}
}
