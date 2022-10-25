//
//  NetworkServices.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

protocol GettingHotelProtocol {
	func fetchHotel(id: Int, completion: @escaping (Result<Hotel, Error>) -> ())
	func fetchHotelsArray(item: URL, completion: @escaping (Result<[Hotel], Error>) -> Void)
	func loadCacheImage(item: Int, imageUrl: String, completion: @escaping(UIImage) -> Void)
}

class NetworkService: GettingHotelProtocol {
	
	
	func fetchHotel(id: Int, completion: @escaping (Result<Hotel, Error>) -> ()) {
		var url: URL { URL(string: "https://raw.githubusercontent.com/iMofas/ios-android-test/master/\(id).json")! }
		request(url: url) { (result: Result<Hotel, Error>) in
			switch result {
			case .success(let data):
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	
	func fetchHotelsArray(item: URL, completion: @escaping (Result<[Hotel], Error>) -> Void) {
		request(url: item) { (result: Result<[Hotel], Error>) in
			switch result {
			case .success(let data):
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	
	private func request<T: Decodable>(url: URL, completion: @escaping(Result<T, Error>) -> Void) {
		guard let url = URL(string:"https://raw.githubusercontent.com/iMofas/ios-android-test/master/0777.json") else { return }
			URLSession.shared.dataTask(with: url) { data, _, error in
				guard let data = data else {
					if let error = error {
						DispatchQueue.main.async {
							completion(.failure(error)) //fix error
							print("check the input Data1")
						}
					}
					return
				}
				
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let result = try decoder.decode(T.self, from: data)
					DispatchQueue.main.async {
						completion(.success(result))
					}
				} catch {
					DispatchQueue.main.async {
						completion(.failure(error))//fix error
						print("check the input Data2")
					}
				}
			}.resume()
		}
	
	
	
	
	
	lazy var cahedataSource: NSCache<AnyObject, UIImage> = {
		let cache = NSCache<AnyObject, UIImage>()
		return cache
	}()
	
	func loadCacheImage(item: Int, imageUrl: String, completion: @escaping(UIImage) -> Void) {
		if let image = cahedataSource.object(forKey: "\(item)" as AnyObject) {
			completion(image)
			//cell.myImageView.image = image
		} else {
			let image = loadImage(imageUrl: imageUrl)
			//let image = loadImage(item: item, cell: cell)
			completion(image)
		}
	}
	
//	private func loadImage(item: Hotel, cell: HotelCell) -> UIImage {
//		var image = UIImage()
//		DispatchQueue.global(qos: .userInitiated).async {
//			guard item.imageUrl != "" else { fatalError() } //fix error
//			guard let apiURL = URL(string: item.imageUrl) else { fatalError() } //fix error
//			let session = URLSession(configuration: .default)
//			let task = session.dataTask(with: apiURL) { data, _, error in
//				guard let data = data, error == nil else { print(error!.localizedDescription); return } //fix error
//				DispatchQueue.main.async {
//					image = UIImage(data: data)!
//					//cell.myImageView.image = UIImage(data: data)!
//				}
//			}
//			task.resume()
//		}
//		return image
//	}
	
	private func loadImage(imageUrl: String) -> UIImage {
		var image = UIImage()
		DispatchQueue.global(qos: .userInitiated).async {
			guard imageUrl != "" else { fatalError() } //fix error
			guard let apiURL = URL(string: imageUrl) else { fatalError() } //fix error
			let session = URLSession(configuration: .default)
			let task = session.dataTask(with: apiURL) { data, _, error in
				guard let data = data, error == nil else { print(error!.localizedDescription); return } //fix error
				DispatchQueue.main.async {
					image = UIImage(data: data)!
				}
			}
			task.resume()
		}
		return image
	}
}
