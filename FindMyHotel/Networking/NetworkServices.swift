//
//  NetworkServices.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//

import Foundation
import UIKit
//MARK: - PROTOCOL
protocol NetworkServiceProtocol {
	func fetchDataFromURL<T: Decodable>(_ url: URL, _ completion: @escaping (Result<T,Error>) -> Void)
}

//MARK: - NETWORK SERVICE
final class NetworkService: NetworkServiceProtocol {
	public func fetchDataFromURL<T: Decodable>(_ url: URL, _ completion: @escaping (Result<T,Error>) -> Void) {
		URLSession.shared.dataTask(with: url) { data, _, error in
			if let error = error { completion(.failure(error)) }
			guard let data = data else { return }
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
				completion(Result{ try decoder.decode(T.self, from: data) })
		}.resume()
	}
}


