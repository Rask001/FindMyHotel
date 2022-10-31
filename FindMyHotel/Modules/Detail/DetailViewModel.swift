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
	let imageDownloader: ImageDownloaderProtocol = ImageDownloader()
	var hotel: Hotel
	var lat: Double?
	var lon: Double?
	var image: String?
	
	required init(hotel: Hotel) {
		self.hotel = hotel
		set()
	}
	
	private func set() {
		networkService.fetchDataFromURL(.getHotelUrl(withID: hotel.id)) { [weak self] (result : Result<Hotel,Error>) in
			guard let self = self else { return }
			switch result {
			case .success(let model):
				self.lon = model.lon ?? 0.0
				self.lat = model.lat ?? 0.0
				self.image = model.image ?? ""
			case .failure(let error):
				AllertService.systemError(error);
			}
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
	
	func downloadImage(completion: @escaping (UIImage) -> Void) {
		guard let imageStrong = image else { completion(ImageDownloader.imageDefault); return }
		guard imageStrong != "" else { completion(ImageDownloader.imageDefault); return }
		let urlKey = URL.getHotelUrl(withID: hotel.id).absoluteString
		if let image = ImageCache.shared.object(forKey: urlKey as NSString) {
			completion(image)
		} else {
			imageDownloader.imageDownloader(url: .getImageUrl(withImageId: imageStrong)) { result in
				switch result {
				case .success(let image):
					ImageCache.shared.setObject(image, forKey: urlKey as NSString)
					completion(image)
				case .failure(_):
					AllertService.errorImageDownload()
					completion(ImageDownloader.imageDefault)
				}
			}
		}
	}

	func fetchHotelForDetailView(completion: @escaping () -> Void) {
		networkService.fetchDataFromURL(.getHotelUrl(withID: hotel.id)) { [weak self] (result : Result<Hotel,Error>) in
			guard let self = self else { return }
			switch result {
			case .success(let model):
				self.hotel = model
				completion()
			case .failure(let error):
				AllertService.systemError(error);
			}
		}
	}
	
	func numberOfRows() -> Int {
		hotel.suitesArray.count
	}
}
