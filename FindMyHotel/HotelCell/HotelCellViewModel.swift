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
	
	//MARK: - ACTIONS
	
	func fetchImage(completion: @escaping (UIImage) -> Void) {
		
		self.networkService.fetchDataFromURL(.getHotelUrl(withID: self.hotel.id)) { [weak self] (result : Result<Hotel,Error>) in
			guard let self = self else { return }
			switch result {
			case .success(let data):
				
				
				guard let imageStrong = data.image else { completion(ImageDownloader.imageDefault); return }
				guard imageStrong != "" else { completion(ImageDownloader.imageDefault); return }
				let urlKey = URL.getHotelUrl(withID: data.id).absoluteString
				
				if let image = ImageCache.shared.object(forKey: urlKey as NSString) {
					completion(image)
				} else {
					self.imageDownloader.imageDownloader(url: .getImageUrl(withImageId: imageStrong)) { result in
						switch result {
						case .success(let image):
							completion(image)
							ImageCache.shared.setObject(image, forKey: urlKey as NSString)
						case .failure(_):
							completion(ImageDownloader.imageDefault)
							ImageCache.shared.setObject(ImageDownloader.imageDefault, forKey: urlKey as NSString)
						}
					}
				}
				
				
			case .failure(_):
				AllertService.errorImageDownload()
			}
		}
	}
}

