//
//  DetailViewModel.swift
//  FindMyHotel
//
//  Created by Антон on 26.10.2022.
//

import Foundation
import UIKit

final class DetailViewModel: DetailViewModelProtocol {

	//MARK: - PROPERTY
	let networkService: NetworkServiceProtocol = NetworkService()
	var hotel: Hotel
	var lat: Double?
	var lon: Double?
	
	required init(hotel: Hotel) {
		self.hotel = hotel
		setLonLat()
	}
	
	private func setLonLat() {
		networkService.loadFromJsonFromURL(.getHotelUrl(withID: hotel.id), Hotel.self) { [weak self] result in
			guard let self else { return }
			self.lon = result.lon ?? 0.0
			self.lat = result.lat ?? 0.0
		}
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
		networkService.loadFromJsonFromURL(.getHotelUrl(withID: hotel.id), Hotel.self) { result in
			ImageDownloader.shared.imageDownloadAndCahed(result: result) { image in
				completion(image)
			}
		}
	}

	func fetchHotelForDetailView(completion: @escaping () -> Void) {
		networkService.loadFromJsonFromURL(.getHotelUrl(withID: hotel.id), Hotel.self) { [weak self] result in
			guard let self else { return }
			self.hotel = result
		}
	}
	
	func numberOfRows() -> Int {
		hotel.suitesArray.count
	}
}
