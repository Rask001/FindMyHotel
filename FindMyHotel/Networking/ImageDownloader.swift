//
//  ImageDownloader.swift
//  FindMyHotel
//
//  Created by Антон on 28.10.2022.
//

import Foundation
import UIKit

final class ImageDownloader {
	
	//MARK: - PROPERTY
	static let shared = ImageDownloader()
	lazy var cache = NSCache<AnyObject, UIImage>()
	
	//MARK: - METHODS
	func imageDownloadAndCahed(result: Result<Hotel, Error>, completion: @escaping (UIImage) -> Void) {
		guard let imageDefault = UIImage(named: "Hotel") else { print(Errors.defaulImageIsNil); return }
		switch result {
		case .success(let data):
			guard data.image != "", data.image != nil else { completion(imageDefault); return }
			guard let imageId = data.image else { return }
			if let image = self.cache.object(forKey: "\(imageId)" as AnyObject) {
				completion(image)
			} else {
				let url: URL = .getImageUrl(withImageId: imageId)
				let session = URLSession(configuration: .default)
				let task = session.dataTask(with: url) { data, _, error in
					guard let data = data, error == nil else { return }
					if let image = UIImage(data: data) {
						self.cache.setObject(image, forKey: "\(imageId)" as AnyObject)
						completion(image)
					} else {
						self.cache.setObject(imageDefault, forKey: "\(imageId)" as AnyObject)
						completion(imageDefault)
					}
				}
				task.resume()
			}
		case .failure(let error):
			print(error.localizedDescription, Errors.incorrectData)
			completion(imageDefault)
			return
		}
	}
}
