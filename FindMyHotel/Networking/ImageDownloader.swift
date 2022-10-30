//
//  ImageDownloader.swift
//  FindMyHotel
//
//  Created by Антон on 28.10.2022.
//

import Foundation
import UIKit

final class ImageDownloader {
	
	//MARK: - CONSTANTS
	private enum Constants {
		static let imageDefault = UIImage(named: "Hotel")!
	}
	
	//MARK: - PROPERTY
	static let shared = ImageDownloader()
	lazy var cache = NetworkService.cache
	
	//MARK: - METHODS
	func imageDownloadAndCahed<T: Decodable>(result: T, completion: @escaping (UIImage) -> Void) {
		
		guard let data = result as? Hotel else { return }
		guard data.image != "", data.image != nil else { completion(Constants.imageDefault); return }
		guard let imageId = data.image else {print(ServerError.IncorrectData); return }
		
		if let image = self.cache.object(forKey: "\(imageId)" as AnyObject) {
			completion(image)
		} else {
			let url: URL = .getImageUrl(withImageId: imageId)
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: url) { data, _, error in
				guard let data = data, error == nil else { print(ServerError.missingData); return }
				if let image = UIImage(data: data) {
					self.cache.setObject(image, forKey: "\(imageId)" as AnyObject)
					completion(image)
				} else {
					self.cache.setObject(Constants.imageDefault, forKey: "\(imageId)" as AnyObject)
					completion(Constants.imageDefault)
				}
			}
			task.resume()
		}
	}
}
