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
}

class NetworkService: GettingHotelProtocol {
	static let shared = NetworkService() //использую только для загрузки картинки из кэша в detailVC (тк локально созданный убиваеться)
	
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
			guard let data = data else { return }
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				let result = try decoder.decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(result))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(Errors.incorrectData))
				}
			}
		}.resume()
	}
}
