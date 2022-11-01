//
//  ImageDownloader.swift
//  FindMyHotel
//
//  Created by Антон on 28.10.2022.
//

import Foundation
import UIKit

protocol ImageDownloaderProtocol {
	func download(url: URL, completion: @escaping (Result<UIImage,Error>) -> Void)
}

final class ImageDownloader: ImageDownloaderProtocol {
	
	//MARK: - PROPERTY
	static let shared = ImageDownloader()
	static let defImage = UIImage(named: "Hotel")!
	//MARK: - METHODS
	
	func download(url: URL, completion: @escaping (Result<UIImage,Error>) -> Void) {
		let session = URLSession(configuration: .default)
		session.dataTask(with: url) { data, response, error in
			if let error = error { completion(.failure(error)) }
			guard let httpResponse = response as? HTTPURLResponse else { return }
			guard let data = data else { return }
			if let image = UIImage(data: data) {
					completion(.success(image))
			} else {
				completion(.failure(ServerError.error404))
				print(httpResponse.statusCode)
			}
		}.resume()
	}
}
