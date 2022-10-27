//
//  NetworkServices.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit

protocol GettingHotelProtocol {
	func fetchHotel(url: URL, completion: @escaping (Result<Hotel, Error>) -> ())
	func fetchHotelsArray(url: URL, completion: @escaping (Result<[Hotel], Error>) -> Void)
	func imageDownloadAndCahed(result: Result<Hotel, Error>, completion: @escaping (UIImage) -> Void)
}

class NetworkService: GettingHotelProtocol {
	static let shared = NetworkService() //использую только для загрузки картинки из кэша в detailVC (тк локально созданный убиваеться)
	var cache = NSCache<AnyObject, UIImage>()
	
	func fetchHotel(url: URL, completion: @escaping (Result<Hotel, Error>) -> ()) {
		request(url: url) { (result: Result<Hotel, Error>) in
			switch result {
			case .success(let data):
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func fetchHotelsArray(url: URL, completion: @escaping (Result<[Hotel], Error>) -> Void) {
		request(url: url) { (result: Result<[Hotel], Error>) in
			switch result {
			case .success(let data):
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	
	private func request<T: Decodable>(url: URL, completion: @escaping(Result<T, Error>) -> Void) {
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
		
	func imageDownloadAndCahed(result: Result<Hotel, Error>, completion: @escaping (UIImage) -> Void) {
		switch result {
		case .success(let data):
			guard let imageId = data.image else { print("error Data"); return }
			
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
					}
				}
				task.resume()
			}
		case .failure(let error):
			print(error.localizedDescription)
		}
	}
}
