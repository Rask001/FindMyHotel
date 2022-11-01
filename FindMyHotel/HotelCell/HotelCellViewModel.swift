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
	var networkService: NetworkServiceProtocol = NetworkService()
	var imageDownloader: ImageDownloaderProtocol = ImageDownloader()
	var hotel: Hotel
	var hotelWithStr: Hotel!
	
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
	
	func setValue() {
		
	}
	
	//MARK: - ACTIONS
	func fetchImage(completion: @escaping (UIImage) -> Void) {
		networkService.fetchDataFromURL(.getHotelUrl(withID: hotel.id)) { [weak self] (result : Result<Hotel,Error>) in
			guard let self = self else { return }
			switch result {
			case .success(let data):
				self.downloadImage(hotelImage: data.image) { completion($0) }
			case .failure(_):
				AllertService.errorImageDownload()
			}
		}
	}
}

//MARK: - DOWNLOAD IMAGE
extension HotelCellViewModel {
	private func downloadImage(hotelImage: String?, completion: @escaping (UIImage) -> Void) {
		let def = ImageDownloader.defImage
		let urlKey = URL.getHotelUrl(withID: hotel.id).absoluteString
		
		guard let imageId = hotelImage else { completion(def); return }
		guard imageId != "" else { completion(def); return }
		if let image = ImageCache.shared.object(forKey: urlKey as NSString) {
			completion(image)
		} else {
			imageDownloader.download(url: .getImageUrl(withImageId: imageId)) { result in
				switch result {
				case .success(let image):
					completion(image)
					ImageCache.shared.setObject(image, forKey: urlKey as NSString)
				case .failure(_):
					completion(def)
					ImageCache.shared.setObject(def, forKey: urlKey as NSString)
				}
			}
		}
	}
}

